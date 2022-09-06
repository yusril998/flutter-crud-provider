import 'package:flutter/material.dart';

///Template bottom sheet yang dipakai di dalam aplikasi
class DefaultBottomSheet extends StatelessWidget {
  ///Menampung daftar widget yang ditampilkan di dalam bottom sheet
  final List<Widget> widgets;
  final bool isScrollView;

  DefaultBottomSheet({required this.widgets, this.isScrollView = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
                margin: EdgeInsets.fromLTRB(16, 4, 16, 16),
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey.shade200)),
          ),
          isScrollView
              ? Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: widgets,
                    ),
                  ),
                )
              : Column(
                  children: widgets,
                )
        ],
      ),
    );
  }
}
