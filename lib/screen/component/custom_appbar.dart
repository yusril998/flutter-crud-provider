import 'package:flutter/material.dart';
import 'package:test_mobile_flutter/screen/main_screen.dart';
import 'package:test_mobile_flutter/screen/search/search_screen.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppbar({key})
      : preferredSize = Size.fromHeight(kToolbarHeight * 1.4),
        super(key: key);
  @override
  final Size preferredSize; // default is 56.0

  TextEditingController searchVal = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: SizedBox(),
      leadingWidth: 0,
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      toolbarHeight: 80,
      bottom: PreferredSize(
          child: Container(
            height: 6,
            decoration: const BoxDecoration(
                gradient:
                    LinearGradient(colors: [Colors.green, Colors.greenAccent])),
          ),
          preferredSize: Size.fromHeight(4.0)),
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: GestureDetector(
          onTap: () {
            _backToHome(context);
          },
          child: Image.asset(
            'assets/icons/logo.png',
            fit: BoxFit.cover,
            height: 30,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 12.0),
          child: GestureDetector(
            onTap: () {
              _showSearchModal(context);
            },
            child: Icon(
              Icons.search,
              size: 25,
            ),
          ),
        ),
      ],
    );
  }

  _showSearchModal(BuildContext context) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black54,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 80),
                child: Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    height: 80,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: Row(children: [
                        Expanded(
                            child: Container(
                          height: 60,
                          margin: EdgeInsets.only(left: 30.0),
                          child: Center(
                            child: TextField(
                                controller: searchVal,
                                decoration: InputDecoration.collapsed(
                                    hintText: "I'm looking for"),
                                onSubmitted: (query) {
                                  Navigator.of(buildContext).pop();
                                  // _showLoadingModal(context);
                                  // Navigator.of(context).pop();
                                  _goToSearch(context, searchVal.text);
                                }),
                          ),
                        )),
                        Padding(
                            padding: EdgeInsets.only(right: 20.0),
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                  _goToSearch(context, searchVal.text);
                                },
                                child: Image.asset(
                                  "assets/icons/search.png",
                                  height: 30,
                                  width: 30,
                                ))),
                      ]),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  /** Fungsi untuk kembali ke menu utama **/
  _backToHome(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      MainScreen.routeName,
      (route) => false,
      arguments: '0',
    );
  }

  _goToSearch(BuildContext context, String query) {
    Navigator.of(context).pushNamed(SearchScreen.routeName, arguments: query);
  }
}
