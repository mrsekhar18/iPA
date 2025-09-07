import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizparan/features/quiz/models/contest.dart';
import 'package:quizparan/features/quiz/quiz_repository.dart';
import 'package:quizparan/utils/datetime_utils.dart';

@immutable
abstract class ContestState {}

class ContestInitial extends ContestState {}

class ContestProgress extends ContestState {}

class ContestSuccess extends ContestState {
  ContestSuccess(this.contestList);

  final Contests contestList;
}

class ContestFailure extends ContestState {
  ContestFailure(this.errorMessage);

  final String errorMessage;
}

class ContestCubit extends Cubit<ContestState> {
  ContestCubit(this._quizRepository) : super(ContestInitial());
  final QuizRepository _quizRepository;

  Future<void> getContest({required String languageId}) async {
    emit(ContestProgress());
    final (:gmt, :localTimezone) = await DateTimeUtils.getTimeZone();

    await _quizRepository
        .getContest(languageId: languageId, timezone: localTimezone, gmt: gmt)
        .then((val) {
          emit(ContestSuccess(val));
        })
        .catchError((Object e) {
          emit(ContestFailure(e.toString()));
        });
  }
}
