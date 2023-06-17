import 'package:battery_plus/battery_plus.dart';
import 'package:injectable/injectable.dart';

@singleton
class BatteryService {
  final Battery _batteryService = Battery();

  Future<int> get level => _batteryService.batteryLevel;
}
