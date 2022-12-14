import 'package:crud_mobile_flutter/const/constant.dart';
import 'package:crud_mobile_flutter/model/category_model.dart';
import 'package:crud_mobile_flutter/screen/component/product_item.dart';
import 'package:crud_mobile_flutter/screen/detail_product/form_product_screen.dart';
import 'package:crud_mobile_flutter/state/category_state.dart';
import 'package:crud_mobile_flutter/state/product_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailKategoriScreen extends StatelessWidget {
  static const routeName = '/detail-kategori';
  final CategoryModel? model;

  const DetailKategoriScreen({this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
        onPressed: () {
          Navigator.of(context)
              .pushNamed(FormProductScreen.routeName, arguments: model!);
        },
        child: Icon(Icons.add),
      ),
      backgroundColor: Constant.background,
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    final state = Provider.of<ProductState>(context);
    final stateCategory = Provider.of<CategoryState>(context);
    final items = state.productList!
        .where((element) => element!.categoryId == model!.id.toString());

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: [
              Image.asset(
                stateCategory.background,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                height: 300,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  gradient: LinearGradient(
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [
                        // Colors.white.withOpacity(0.30),
                        Colors.green.shade800.withOpacity(0.35),
                        Colors.green.shade800.withOpacity(0.40),
                        Colors.green.shade800.withOpacity(0.50),
                        Colors.black.withOpacity(0.50),
                        Colors.black.withOpacity(0.75),
                      ]),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      model!.name!,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                      child: Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus quis feugiat diam. Cras ultrices vulputate tortor, quis lacinia lacus iaculis volutpat. Praesent eu odio eget dolor finibus vestibulum. Praesent purus felis.",
                        style: TextStyle(color: Colors.white, fontSize: 13),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Text(
              'Product Terkait',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Padding(
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
              children: items
                  .map(
                    (model) => ProductItem(model: model),
                  )
                  .toList(),
            ),
          ),
          SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}
