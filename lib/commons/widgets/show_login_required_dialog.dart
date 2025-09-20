import 'package:flutter/material.dart';
import 'package:quizapp/commons/widgets/custom_alert_dialog.dart';
import 'package:quizapp/core/core.dart';

Future<void> showLoginRequiredDialog(BuildContext context) {
  return showAlertDialog(
    context,
    title: context.tr('loginRequired'),
    message: context.tr('loginRequiredDesc'),
    cancelButtonText: context.tr('cancel'),
    confirmButtonText: context.tr('loginLbl'),
    barrierDismissible: false,
    onConfirm: () => globalCtx.pushNamed(Routes.login),
  );
}
