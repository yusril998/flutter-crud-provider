import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:crud_mobile_flutter/model/product/product_model.dart';
import 'package:crud_mobile_flutter/screen/component/loading.dart';
import 'package:crud_mobile_flutter/screen/detail_product/detail_product_screen.dart';
import 'package:crud_mobile_flutter/screen/detail_product/form_product_screen.dart';
import 'package:crud_mobile_flutter/state/product_state.dart';
import 'package:crud_mobile_flutter/const/constant.dart';

class ProductItem extends StatelessWidget {
  final ProductModel? model;

  const ProductItem({this.model});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width * .7;
    final state = Provider.of<ProductState>(context);
    DateFormat outputFormat = DateFormat("dd MMM yyyy");

    String tanggal = outputFormat.format(DateTime.parse(model!.createdAt!));

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, DetailProductScreen.routeName,
            arguments: model);
      },
      child: Column(
        children: <Widget>[
          Container(
            height: width,
            decoration: BoxDecoration(
              //color: Colors.green.shade800,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: model!.image!,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Padding(
                      padding: EdgeInsets.all(3),
                      child: CircularProgressIndicator(
                        value: downloadProgress.progress,
                        color: Constant.primary,
                      ),
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/img/noimage.jpeg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: Colors.white,
                      gradient: Constant.gradientImage,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                          margin: EdgeInsets.only(left: 5),
                          decoration: BoxDecoration(
                              gradient: Constant.gradient,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 5.0,
                                  offset: const Offset(0.1, 0.1),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.green.shade900),
                          child: Text(
                            model!.getCategory!.name!,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            model!.title!,
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.white,
                                height: 1.7,
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            model!.slug!,
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10, top: 7),
                              child: Text(
                                tanggal,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 11, color: Colors.white),
                              ),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    FormProductScreen.routeName,
                                    arguments: model!);
                              },
                              child: SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 18,
                                  )),
                            ),
                            InkWell(
                              onTap: () async {
                                showLoading(context);
                                await state.deleteProduct(model);
                                hideLoading(context);
                              },
                              child: const SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 18,
                                  )),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
