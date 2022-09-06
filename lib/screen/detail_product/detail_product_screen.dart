import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_mobile_flutter/model/product_model.dart';
import 'package:test_mobile_flutter/screen/component/general_appbar.dart';
import 'package:test_mobile_flutter/screen/component/product_other.dart';
import 'package:test_mobile_flutter/state/product_state.dart';
import 'package:test_mobile_flutter/const/constant.dart';

class DetailProductScreen extends StatelessWidget {
  static const routeName = '/detail-video';
  final ProductModel? model;

  const DetailProductScreen({required this.model});

  @override
  Widget build(BuildContext context) {
    final selectedVideo = model;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: GeneralAppbar(
        title: selectedVideo!.getCategory!.name,
      ),
      body: _buildContent(context),
    );
  }

  /** builder method untuk konten secara keseluruhan **/
  Widget _buildContent(BuildContext context) {
    final state = Provider.of<ProductState>(context, listen: true);
    final selectedVideo = model!;
    DateFormat outputFormat = DateFormat("MMMM yyyy");

    String tanggal =
        outputFormat.format(DateTime.parse(selectedVideo.createdAt!));

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // !_isLoading
          //     ?
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 30),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  selectedVideo.title!,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 18),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  //margin: EdgeInsets.only(left: 5),
                  decoration: BoxDecoration(
                      gradient: Constant.gradient,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 1.0,
                          offset: const Offset(0.1, 0.1),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green.shade900),
                  child: Text(
                    selectedVideo.getCategory!.name!,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.white,
                      height: 1.5,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Text('Slug : ${selectedVideo.slug}',
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 12)),
                    ),
                    Text(tanggal,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 12))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                    child: Text(selectedVideo.description!,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                            height: 1.5,
                            fontWeight: FontWeight.w400,
                            fontSize: 12))),
              ],
            ),
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
