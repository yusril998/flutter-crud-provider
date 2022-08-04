import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Future<void> showLoading(BuildContext context) async {
  showDialog<dynamic>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      dialogContext = context;
      return Material(
        type: MaterialType.transparency,
        child: Center(
          child: Container(
            alignment: Alignment.center,
            child: SpinKitSquareCircle(
              color: Colors.white,
              size: 50.0,
            ),
          ),
        ),
      );
    },
  );
}

Future<void> hideLoading(BuildContext context) async {
  Navigator.pop(context);
}

Future<void> backScreen(BuildContext context) async {
  Navigator.pop(context);
}

Future backtwoscreen(BuildContext context) async {
  int count = 0;
  return Navigator.of(context).popUntil((_) => count++ >= 2);
}

Future backthreescreen(BuildContext context) async {
  int count = 0;
  return Navigator.of(context).popUntil((_) => count++ >= 3);
}

Future backfourscreen(BuildContext context) async {
  int count = 0;
  return Navigator.of(context).popUntil((_) => count++ >= 4);
}
