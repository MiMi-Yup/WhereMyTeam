import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:wmteam/domain/use_cases/route_usecases.dart';
import 'package:wmteam/models/model_route.dart';
import 'package:wmteam/models/model_user.dart';
import 'package:wmteam/utils/time_util.dart';

part 'route_state.dart';

@injectable
class RouteCubit extends Cubit<RouteState> {
  final RouteUseCases usecase;
  final ModelUser? user;
  RouteCubit({required this.usecase, required this.user})
      : super(RouteState.initial());

  Future<bool> loadRoutes() async {
    final routes = await user?.routesEx;
    if (routes == null || routes.isEmpty) return false;
    final groupSorted = _sortByTime(result: _mappingCompareTimeCreate(routes));
    emit(state.copyWith(routes: groupSorted));
    return true;
  }

  Map<String, List<ModelRoute>> _mappingCompareTimeCreate(
      List<ModelRoute> routes) {
    Map<String, List<ModelRoute>> map = {};
    for (var element in routes) {
      final key = element.endTime?.toMinimalDate;
      if (key == null) continue;
      if (map.containsKey(key)) {
        map[key]?.add(element);
      } else {
        map.addAll({
          key: [element]
        });
      }
    }
    return map;
  }

  SplayTreeMap<String, List<ModelRoute>?> _sortByTime(
      {required Map<String, List<ModelRoute>> result}) {
    //sort each group by timeCreate
    for (String element in result.keys) {
      result[element]!.sort((model1, model2) {
        return model1.endTime!.compareTo(model2.endTime!);
      });
    }

    //sort key of group
    return SplayTreeMap<String, List<ModelRoute>?>.from(result,
        (key1, key2) => key2.parseMinimalDate.compareTo(key1.parseMinimalDate));
  }
}
