import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crud_mobile_flutter/screen/home/home_screen.dart';
import 'package:crud_mobile_flutter/state/category_state.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<MainScreen> {
  int currentPage = 0;

  @override
  void initState() {
    initialState();
    super.initState();
  }

  initialState() {
    final categoryState = Provider.of<CategoryState>(context, listen: false);
    categoryState.getListCategory();
  }

  @override
  Widget build(BuildContext context) {
    final categoryState = Provider.of<CategoryState>(context);
    return Scaffold(
      body: Builder(builder: (context) {
        return categoryState.isBusy
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(child: _body(context));
      }),
    );
  }

  Widget _body(BuildContext context) {
    return HomeScreen();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
