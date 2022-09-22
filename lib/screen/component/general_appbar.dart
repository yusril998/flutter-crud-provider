import 'package:flutter/material.dart';

class GeneralAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  GeneralAppbar({this.title = '-', key})
      : preferredSize = Size.fromHeight(kToolbarHeight * 1.4),
        super(key: key);
  @override
  final Size preferredSize; // default is 56.0

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Color(0xFF3E3E3E)),
      backgroundColor: const Color(0xFFF5F5F5),
      centerTitle: true,
      toolbarHeight: 80,
      elevation: 0,
      title: Text(
        title!,
        style: TextStyle(
          color: Color(0xFF3E3E3E),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}


