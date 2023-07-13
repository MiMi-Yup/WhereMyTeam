import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:wmteam/data/data_source/remote/cloud_storage_service.dart';
import 'package:wmteam/domain/repositories/unit_of_work.dart';
import 'package:wmteam/models/model_user.dart';

@injectable
class UserUseCases {
  final UnitOfWork unitOfWork;

  UserUseCases({required this.unitOfWork});

  void setLanguage(Locale locale) {
    unitOfWork.sharedPref.setLanguage(locale);
  }

  void setTheme(ThemeMode mode) {
    unitOfWork.sharedPref.setTheme(mode);
  }

  Future<Uint8List?> getAvatar() async {
    final user = await unitOfWork.user.getCurrentUser();
    if (user == null || user.avatar == null) return null;
    return CloudStorageService.downloadFile(user.avatar!);
  }

  Future<List<ModelUser>?> getFriend() {
    return unitOfWork.user.getFriend();
  }

  Future<List<ModelUser>?> getRequestsFriend() async {
    final requests = await unitOfWork.friends.getRequests();
    if (requests == null || requests.isEmpty) return null;
    final userRequests = await Future.wait(
        requests.map((e) => unitOfWork.user.getModelByRef(e.sender!)));
    return userRequests
        .where((element) => element != null)
        .cast<ModelUser>()
        .toList();
  }

  Future<int> getCountRequestsFriend() async {
    final requests = await unitOfWork.friends.getRequests();
    return requests?.length ?? 0;
  }
}
