import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_quiz_app/utils/colors.dart';

void showErrorMessage(
    {required String message, required BuildContext context}) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
            backgroundColor: AppColors.white,
            title: const Text(
              'Error',
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
            content: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                message,
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: AppColors.C_273032),
              ),
            ),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                isDefaultAction: true,
                child: const Text('ok'),
              )
            ],
          ));
}

Future<void> showConfirmMessage({
  required String message,
  required BuildContext context,
}) async {
  await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            backgroundColor: Colors.white,
            content: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                message,
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: AppColors.C_273032),
              ),
            ),
            actions: [
              CupertinoDialogAction(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  isDefaultAction: true,
                  child: const Text('ok'))
            ],
          ));
}
