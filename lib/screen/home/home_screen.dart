import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crud_mobile_flutter/screen/component/custom_appbar.dart';
import 'package:crud_mobile_flutter/screen/detail_kategori/detail_kategori_screen.dart';
import 'package:crud_mobile_flutter/screen/home/halaman_utama.dart';
import 'package:crud_mobile_flutter/state/category_state.dart';
import 'package:crud_mobile_flutter/const/constant.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen();
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  ScrollController scrollController = ScrollController();

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

    return DefaultTabController(
        length: categoryState.categoryList!.length,
        initialIndex: 0,
        child: Scaffold(
            appBar: CustomAppbar(),
            body: Column(
              children: <Widget>[
                Container(
                  height: 52,
                  child: TabBar(
                    padding: EdgeInsets.only(
                        bottom: 10, top: 10, left: 20, right: 20),
                    labelPadding: EdgeInsets.zero,
                    isScrollable: true,
                    indicatorPadding: EdgeInsets.zero,
                    unselectedLabelColor: Colors.black,
                    unselectedLabelStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                    labelColor: Colors.white,
                    labelStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                    indicatorSize: TabBarIndicatorSize.label,
                    onTap: (index) {
                      print(index);
                    },
                    indicator: BoxDecoration(
                        gradient: Constant.gradient,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey.shade400,
                            blurRadius: 5.0,
                            offset: const Offset(0.4, 4.4),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.green.shade900),
                    tabs: categoryState.categoryList!.map((kategori) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Tab(text: kategori!.name),
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                    child: TabBarView(
                  children: categoryState.categoryList!.map((e) {
                    if (e!.code == "halaman_utama") {
                      return HalamanUtama();
                    } else if (e.code == "tambah_kategori") {
                      return HalamanUtama();
                    } else {
                      return DetailKategoriScreen(
                        model: e,
                      );
                    }
                  }).toList(),
                )),
              ],
            )));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
