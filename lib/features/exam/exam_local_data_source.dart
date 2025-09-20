import 'package:hive_flutter/adapters.dart';
import 'package:quizapp/core/constants/constants.dart';

class ExamLocalDataSource {
  Box<dynamic> get _box => Hive.box<dynamic>(examBox);

  Future<void> addExamModuleId(String examModuleId) =>
      _box.put(examModuleId, examModuleId);

  Future<void> removeExamModuleId(String examModuleId) =>
      _box.delete(examModuleId);

  List<String> getAllExamModuleIds() {
    final examModuleIds = <String>[];

    for (var i = 0; i < _box.length; i++) {
      examModuleIds.add(_box.getAt(i) as String);
    }

    return examModuleIds;
  }
}
