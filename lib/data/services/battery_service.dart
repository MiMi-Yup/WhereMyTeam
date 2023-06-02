import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:where_my_team/data/data_source/local/battery_service.dart'
    as services;
import 'package:where_my_team/domain/repositories/unit_of_work.dart';
import 'package:where_my_team/domain/services/battery_service.dart' as logic;

@lazySingleton
@Injectable(as: logic.BatteryService)
class BatteryServiceImpl implements logic.BatteryService {
  final services.BatteryService service;
  final UnitOfWork unitOfWork;
  Timer? _timer;

  BatteryServiceImpl({required this.service, required this.unitOfWork});

  void _eventTimer(_) async {
    final int level = await service.level;
    unitOfWork.user.putBattery(level: level);
  }

  @override
  void updateBattery() {
    if (_timer != null) {
      _timer = Timer.periodic(const Duration(minutes: 30), _eventTimer);
    }
  }

  @disposeMethod
  void dispose() {
    _timer?.cancel();
    _timer = null;
  }
  
  @override
  void userLogout() {
    dispose();
  }
}
