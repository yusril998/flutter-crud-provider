import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crud_mobile_flutter/model/product_model.dart';
import 'package:crud_mobile_flutter/screen/component/general_appbar.dart';
import 'package:crud_mobile_flutter/screen/component/product_item.dart';
import 'package:crud_mobile_flutter/screen/component/product_other.dart';
import 'package:crud_mobile_flutter/state/product_state.dart';
import 'package:crud_mobile_flutter/const/constant.dart';

class SearchScreen extends StatelessWidget {
  static const routeName = '/search';
  final String? query;

  const SearchScreen({required this.query});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.background,
      appBar: GeneralAppbar(
        title: 'Pencarian',
      ),
      body: _buildContent(context),
    );
  }

  Widget _buildSearchedVid(BuildContext context, String query) {
    final state = Provider.of<ProductState>(context);
    final List<ProductModel?> items = state.productList!
        .where((element) =>
            element!.title!.toLowerCase().contains(query.toLowerCase()) ||
            element.slug!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    if (items.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: GridView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1 / 1.6,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          children: items.map((item) => ProductItem(model: item)).toList(),
        ),
      );
    } else {
      return Container(
        height: 100,
        width: double.infinity,
        child: Center(child: Text("Hasil pencarian tidak ditemukan")),
      );
    }
  }

  /** builder method untuk konten secara keseluruhan **/
  Widget _buildContent(BuildContext context) {
    final state = Provider.of<ProductState>(context, listen: true);

    String query = ModalRoute.of(context)!.settings.arguments as String;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Text(
              'Hasil pencarian : "$query"',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w700),
            ),
          ),
          _buildSearchedVid(context, query),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Rekomendasi Untukmu',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) => SizedBox(
                height: 15,
              ),
              itemCount: state.productList!.length,
              separatorBuilder: (BuildContext context, int index) {
                var e = state.productList![index];
                return ProductOther(model: e);
              },
            ),
          )
        ],
      ),
    );
  }
}
