import 'dart:io';

import 'package:flutter/material.dart';
import 'package:test_mobile_flutter/model/category_model.dart';
import 'package:test_mobile_flutter/services/api/api_category.dart';

import 'package:test_mobile_flutter/const/constant.dart';

class CategoryState extends ChangeNotifier {
  ApiCategory repository = ApiCategory();

  int _page = 1;
  int get page => _page;

  bool _isLoadMore = true;
  bool get isLoadMore => _isLoadMore;

  List<CategoryModel?>? _categoryList = [];
  List<CategoryModel?>? get categoryList => _categoryList;

  bool _isBusy = false;
  bool get isBusy => _isBusy;

  Future<void> getListCategory() async {
    try {
      _page = 1;
      _isBusy = true;
      var response = await repository.getListCategory();
      _categoryList = response;
      _categoryList!.insert(0,
          CategoryModel(id: 0, name: "Halaman Utama", code: 'halaman_utama'));
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

  Future<String?> deleteCategory(CategoryModel? model) async {
    try {
      String? response = "";

      response = await repository.deleteCategory(model!.id!.toString());

      for (var i = 0; i < _categoryList!.length; i++) {
        if (_categoryList![i]!.id == model.id) {
          _categoryList!.removeAt(i);
        }
      }

      notifyListeners();
      return response;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> savePostCategory(String code, String name,
      {CategoryModel? oldModel}) async {
    try {
      String retVal = "";
      CategoryModel? response;
      if (oldModel != null) {
        response = await repository.editCategory(oldModel.id!, code, name);
      } else {
        response = await repository.postCategory(code, name);
      }
      if (response != null) {
        retVal = "1";
        if (oldModel != null) {
          var CategoryRawList = _categoryList;
          for (var i = 0; i < CategoryRawList!.length; i++) {
            if (CategoryRawList[i]!.id == oldModel.id) {
              /// smeentara di ganti ke old
              _categoryList![i] = response;
              notifyListeners();
            }
          }

          notifyListeners();
        } else {
          _categoryList!.insert(0, response);
          notifyListeners();
        }
      } else {
        retVal = "Terjadi kesalahan";
      }

      //await getListCategory();
      return retVal;
    } catch (e) {
      return e.toString();
    }
  }
}
