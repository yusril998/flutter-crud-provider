import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_mobile_flutter/model/product_model.dart';
import 'package:test_mobile_flutter/screen/component/loading.dart';
import 'package:test_mobile_flutter/screen/detail_product/detail_product_screen.dart';
import 'package:test_mobile_flutter/screen/detail_product/form_product_screen.dart';
import 'package:test_mobile_flutter/state/product_state.dart';
import 'package:test_mobile_flutter/const/constant.dart';

class ProductOther extends StatelessWidget {
  final ProductModel? model;

  const ProductOther({this.model});

  @override
  Widget build(BuildContext context) {
    DateFormat outputFormat = DateFormat("dd MMM yyyy");
    String tanggal = outputFormat.format(DateTime.parse(model!.createdAt!));
    final state = Provider.of<ProductState>(context);
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, DetailProductScreen.routeName,
            arguments: model);
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
        ),
        child: Row(
          children: <Widget>[
            Container(
              height: 150,
              width: 110,
              margin: EdgeInsets.only(
                right: 10,
                top: 7,
                bottom: 7,
                left: 7,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: model!.image!,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Padding(
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
            ),
            Expanded(
                child: Container(
              height: 170,
              child: Column(
                children: [
                  Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 5, top: 20, right: 10),
                      child: Text(
                        model!.title!,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13),
                      )),
                  Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 5, top: 15, right: 10),
                      child: Text(
                        model!.slug!,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 12),
                      )),
                  Spacer(),
                  Container(
                    height: 50,
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 10, right: 10),
                    child: Row(
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              margin: EdgeInsets.only(left: 5),
                              decoration: BoxDecoration(
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
                              child: Text(
                                model!.getCategory!.name!,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 10, top: 7),
                                  child: Text(
                                    tanggal,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 11,
                                    ),
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
                                        color: Colors.black,
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
                                        color: Colors.black,
                                        size: 18,
                                      )),
                                )
                              ],
                            ),
                          ],
                        )),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
