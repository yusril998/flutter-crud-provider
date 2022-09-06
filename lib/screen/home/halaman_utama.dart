import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_mobile_flutter/screen/component/product_other.dart';
import 'package:test_mobile_flutter/state/product_state.dart';
import 'package:test_mobile_flutter/const/constant.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HalamanUtama extends StatefulWidget {
  const HalamanUtama({Key? key}) : super(key: key);

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  int _currentIndex = 0;
  List imageList = [
    "assets/img/banner.jpeg",
    "assets/img/banner_a.jpeg",
    "assets/img/banner_b.jpeg",
    "assets/img/banner_c.jpeg"
  ];

  @override
  void initState() {
    final state = Provider.of<ProductState>(context, listen: false);
    state.getListProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ProductState>(context);

    return state.isBusy
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            color: Constant.background,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      height: 100.0,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      pauseAutoPlayOnTouch: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      viewportFraction: 1.1,
                    ),
                    items: imageList.map((image) {
                      return Container(
                        margin: EdgeInsets.only(
                          left: 40,
                          right: 40,
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(image as String,
                                fit: BoxFit.fitHeight)),
                        decoration: BoxDecoration(),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 5,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imageList.map((image) {
                      final int index = imageList.indexOf(image);
                      return Container(
                        width: 5.0,
                        height: 5.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentIndex == index
                              ? Colors.green
                              : Colors.grey,
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Text(
                      'Promo',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      child: YoutubePlayer(
                          controller: YoutubePlayerController(
                              initialVideoId:
                                  'https://youtu.be/Faow3SKIzq0', //Add videoID.
                              flags: YoutubePlayerFlags(
                                hideControls: false,
                                controlsVisibleAtStart: true,
                                autoPlay: false,
                                mute: false,
                              )),
                          showVideoProgressIndicator: true,
                          progressIndicatorColor: Colors.greenAccent),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Produk',
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
                      itemBuilder: (BuildContext context, int index) =>
                          SizedBox(
                        height: 15,
                      ),
                      itemCount: state.productList!.length,
                      separatorBuilder: (BuildContext context, int index) {
                        var e = state.productList![index];
                        return ProductOther(model: e);
                      },
                    ),
                  )
                  //Footer(),
                ],
              ),
            ),
          );
  }
}
