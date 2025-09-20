import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizapp/core/localization/app_localization_cubit.dart';

extension LocalizedLabelsExt on BuildContext {
  String? tr(String key) => read<AppLocalizationCubit>().tr(key) ?? key;
}
