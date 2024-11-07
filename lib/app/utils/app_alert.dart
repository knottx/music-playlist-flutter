import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:music_playlist/generated/app_localizations.dart';

class AppAlert {
  AppAlert._();

  static Future<void> error(
    BuildContext context, {
    required Object? error,
  }) {
    final errorMessage =
        error is FormatException ? error.message : error.toString();
    return dialog(
      context,
      title: AppLocalizations.of(context).errorTitle,
      message: errorMessage,
    );
  }

  static Future<void> dialog(
    BuildContext context, {
    required String title,
    required String? message,
  }) {
    return showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog.adaptive(
          title: Text(title),
          content: message != null ? Text(message) : null,
          actions: [
            Platform.isIOS
                ? CupertinoDialogAction(
                    onPressed: () {
                      dialogContext.pop();
                    },
                    child: Text(AppLocalizations.of(context).ok),
                  )
                : TextButton(
                    onPressed: () {
                      dialogContext.pop();
                    },
                    child: Text(AppLocalizations.of(context).ok),
                  ),
          ],
        );
      },
    );
  }
}
