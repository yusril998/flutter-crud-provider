import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:test_mobile_flutter/model/product_model.dart';
import 'package:test_mobile_flutter/services/api/api_product.dart';
import 'package:test_mobile_flutter/const/constant.dart';

class ProductState extends ChangeNotifier {
  ApiProduct repository = ApiProduct();

  int _page = 1;
  int get page => _page;

  bool _isLoadMore = true;
  bool get isLoadMore => _isLoadMore;

  bool _isLoadMoreDetail = true;
  bool get isLoadMoreDetail => _isLoadMoreDetail;

  List<ProductModel?>? _productList = [];
  List<ProductModel?>? get productList => _productList;

  bool _isBusy = false;
  bool get isBusy => _isBusy;

  bool _isBusyGlobal = false;
  bool get isBusyGlobal => _isBusyGlobal;

  ProductModel? _detailProduct;
  ProductModel? get detailProduct => _detailProduct;
  setDetailProduct(ProductModel data) {
    _detailProduct = data;
  }

  Future<void> getListProduct() async {
    try {
      _page = 1;
      _isBusy = true;
      var response = await repository.getListProduct();
      _productList = response;
      inspect(response);

      _isLoadMore = true;
      if (response!.length < Constant.limit) {
        _isLoadMore = false;
      }
      _isBusy = false;

      notifyListeners();
    } catch (ex) {
      _isBusy = false;

      notifyListeners();
    }
  }

  Future<String?> deleteProduct(ProductModel? model) async {
    try {
      String? response = "";

      response = await repository.deleteProduct(model!.id!.toString());

      for (var i = 0; i < _productList!.length; i++) {
        if (_productList![i]!.id == model.id) {
          _productList!.removeAt(i);
        }
      }

      notifyListeners();
      return response;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> savePostProduct(
      String title, String slug, String category, String desc, File? file,
      {ProductModel? oldModel}) async {
    try {
      String retVal = "";
      ProductModel? response;
      if (oldModel != null) {
        response = await repository.editProduct(
            oldModel.id!, title, slug, category, desc, file);
      } else {
        response = await repository.postProduct(
          title,
          slug,
          category,
          desc,
          file,
        );
      }
      getListProduct();
      if (response != null) {
        retVal = "1";
        // if (oldModel != null) {
        //   var ProductRawList = _productList;
        //   for (var i = 0; i < ProductRawList!.length; i++) {
        //     if (ProductRawList[i]!.id == oldModel.id) {
        //       /// smeentara di ganti ke old
        //       _productList![i] = response;
        //       notifyListeners();
        //     }
        //   }

        //   notifyListeners();
        // } else {
        //   _productList!.insert(0, response);
        //   notifyListeners();
        // }
      } else {
        retVal = "Terjadi kesalahan";
      }

      return retVal;
    } catch (e) {
      return e.toString();
    }
  }
}
