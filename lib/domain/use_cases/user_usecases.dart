import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:where_my_team/data/data_source/remote/cloud_storage_service.dart';
import 'package:where_my_team/domain/repositories/unit_of_work.dart';

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
}
