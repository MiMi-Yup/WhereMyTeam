import 'dart:async';
import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:location/location.dart';
import 'package:where_my_team/domain/repositories/unit_of_work.dart';
import 'package:where_my_team/domain/services/location_service.dart';
import 'package:where_my_team/models/model_location.dart';
import 'package:where_my_team/models/model_route.dart';
import 'package:where_my_team/models/model_user.dart';
import 'package:where_my_team/utils/extensions/location_extension.dart';

enum TypeRoute { nothing, walk, cycle, bike, roll }

@lazySingleton
@Injectable(as: LocationService)
class LocationServiceImpl implements LocationService {
  final Map<TypeRoute, double> minSpeedOfTypeRoute = {
    TypeRoute.nothing: 0,
    //Đi bộ, trigger 5km/h
    TypeRoute.walk: 5 / 3.6,
    //Đi xe đạp, trigger 15km/h
    TypeRoute.cycle: 15 / 3.6,
    //Đi xe máy, trigger 30km/h
    TypeRoute.bike: 30 / 3.6,
    //Đi xe hơi, trigger 60km/h
    TypeRoute.roll: 60 / 3.6
  };

  final UnitOfWork unitOfWork;
  final Queue<LocationData> queue = Queue();
  final Duration _checkDuration = const Duration(minutes: 1);
  final double _triggerDistance = (5 / 3.6) * 60 * 1;

  StreamSubscription<LocationData>? _subscriptionLocation;
  StreamSubscription<LocationData>? _subscriptionRoute;
  ModelRoute? _currentRoute;
  Timer? _timer;

  LocationServiceImpl({required this.unitOfWork});

  Future<void> _eventLocation(LocationData event) async {
    ModelUser? user = await unitOfWork.user.getCurrentUser();
    if (user != null) {
      DocumentReference? routeRef =
          currentRoute != null ? unitOfWork.route.getRef(currentRoute!) : null;
      ModelLocation location = ModelLocation(
          id: event.time?.toInt().toString(),
          user: unitOfWork.user.getRef(user),
          route: routeRef,
          timestamp: event.time == null
              ? Timestamp.now()
              : Timestamp.fromMillisecondsSinceEpoch(event.time!.toInt()),
          altitude: event.altitude,
          latitude: event.latitude,
          longitude: event.longitude,
          satelliteNumber: event.satelliteNumber,
          speed: event.speed);
      unitOfWork.location.insert(location);
      unitOfWork.user.putLastLocation(lastLocation: location);
      if (_currentRoute != null) {
        ModelLocation? preLocation = await user.lastLocationEx;
        double? distance = preLocation?.distance(location);
        final updateCurrentRoute = _currentRoute!.copyWith(
            distance: _currentRoute!.distance + (distance ?? 0),
            maxSpeed: _currentRoute!.maxSpeed < (event.speed ?? 0)
                ? event.speed
                : _currentRoute!.maxSpeed);
        await unitOfWork.route.update(_currentRoute!, updateCurrentRoute);
        _currentRoute = updateCurrentRoute;
      }
    }
  }

  Future<void> _eventRoute(LocationData event) async {
    queue.add(event);
  }

  Future<void> _newRoute(TypeRoute type,
      {List<LocationData>? queueLocation}) async {
    final dbTypeRoute =
        await unitOfWork.typeRoute.getModelByName(name: type.name);
    if (dbTypeRoute == null) return;
    _currentRoute = await unitOfWork.route.postRoute(
        newRoute: ModelRoute(
            id: null,
            startTime: Timestamp.now(),
            isShared: true,
            typeRoute: unitOfWork.typeRoute.getRef(dbTypeRoute)));
    if (_currentRoute?.id == null) return;
    //update locations not yet has route.
    if (queueLocation != null && queueLocation.isNotEmpty) {
      final updateLocations = await Future.wait(queueLocation
          .where((element) => element.time != null)
          .map((e) =>
              unitOfWork.location.getLocation(id: e.time!.toInt().toString())));
      Future.wait(updateLocations.where((element) => element != null).map((e) =>
          unitOfWork.location.update(
              e!, e.copyWith(route: unitOfWork.route.getRef(_currentRoute!)))));
    }
  }

  Future<void> _endRoute() async {
    await unitOfWork.route.update(
        _currentRoute!, _currentRoute!.copyWith(endTime: Timestamp.now()));
    _currentRoute = null;
    queue.clear();
  }

  void _eventTimer(Timer timer) async {
    if (queue.isEmpty) return;
    LocationData last = queue.last;
    if (Duration(milliseconds: last.time!.toInt() - queue.first.time!.toInt())
            .compareTo(_checkDuration) >=
        0) {
      final List<LocationData> listCheck = queue.toList();
      double distance = 0.0;
      double avgSpeed = 0.0;
      double maxSpeed = 0.0;
      final length = listCheck.length - 1; //-1 becasuse [index + 1]
      for (int index = 0; index < length; index++) {
        distance += listCheck[index].distance(listCheck[index + 1]);
        maxSpeed = (listCheck[index].speed ?? 0) > maxSpeed
            ? listCheck[index].speed ?? 0
            : maxSpeed;
      }
      avgSpeed = distance / _checkDuration.inSeconds;
      //condition trigger
      if (distance < _triggerDistance) {
        if (_currentRoute != null) {
          await _endRoute();
        }
      } else if (_currentRoute == null) {
        final typeRoute = minSpeedOfTypeRoute.entries.lastWhere(
            (element) => element.value < avgSpeed || element.value < maxSpeed);
        if (typeRoute.key != TypeRoute.nothing) {
          //start route
          await _newRoute(typeRoute.key, queueLocation: listCheck);
        }
      }
    } else if (_currentRoute != null &&
        queue.isNotEmpty &&
        Duration(
                    milliseconds: queue.last.time!.toInt() +
                        _checkDuration.inMilliseconds)
                .compareTo(Duration(
                    milliseconds: Timestamp.now().millisecondsSinceEpoch)) <=
            0) {
      await _endRoute();
    }
    while (queue.isNotEmpty &&
        Duration(milliseconds: last.time!.toInt() - queue.first.time!.toInt())
                .compareTo(_checkDuration) >=
            0) {
      queue.removeFirst();
    }
  }

  @override
  Future<void> updateLocation() async {
    if (_subscriptionLocation == null &&
        _subscriptionRoute == null &&
        _timer == null &&
        await unitOfWork.gps.checkPermission() == true) {
      Stream<LocationData>? stream = await unitOfWork.gps.getStream();
      if (stream != null) {
        _subscriptionRoute = stream.listen(_eventRoute);
        _subscriptionLocation = stream.listen(_eventLocation);
        _timer = Timer.periodic(const Duration(seconds: 20), _eventTimer);
      }
    }
  }

  @disposeMethod
  void dispose() {
    _subscriptionLocation?.cancel();
    _subscriptionRoute?.cancel();
    _timer?.cancel();
  }

  @override
  ModelRoute? get currentRoute => _currentRoute;
}
