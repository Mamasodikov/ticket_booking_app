import 'package:flutter/cupertino.dart';
import 'package:ticket_booking_app/core/utils/string_enums.dart';

Future<bool?> showAlert(BuildContext context, String ask) async {
  return await showCupertinoDialog<bool>(
      context: context,
      builder: (BuildContext ctx) {
        return CupertinoAlertDialog(
          title: Text(confirmation),
          content: Text(ask),
          actions: [
            // The "Yes" button
            CupertinoDialogAction(
                onPressed: () {
                  // Close the dialog
                  Navigator.of(context).pop(true);
                },
                child: Text(YES)),
            CupertinoDialogAction(
                onPressed: () {
                  // Close the dialog
                  Navigator.of(context).pop(false);
                },
                child: Text(NO))
          ],
        );
      });
}

Future<bool?> showAlertText(BuildContext context, String question) async {
  return await showCupertinoDialog<bool>(
      context: context,
      builder: (BuildContext ctx) {
        return CupertinoAlertDialog(
          title: Text(confirmation),
          content: Text(question),
          actions: [
            // The "Yes" button
            CupertinoDialogAction(
                onPressed: () {
                  // Close the dialog
                  Navigator.of(context).pop(true);
                },
                child: Text(YES)),
            CupertinoDialogAction(
                onPressed: () {
                  // Close the dialog
                  Navigator.of(context).pop(false);
                },
                child: Text(NO))
          ],
        );
      });
}
