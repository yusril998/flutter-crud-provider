import 'package:dio/dio.dart';
import 'package:test_mobile_flutter/model/category_model.dart';

import 'package:test_mobile_flutter/services/api/api.dart';

class ApiCategory extends Api {
  Future<List<CategoryModel?>?> getListCategory() async {
    try {
      Response? json = await get("category/get-all");
      List<CategoryModel?>? response = [];
      if (json!.statusCode == 200) {
        var rawData = json.data['data'];
        rawData.forEach((element) {
          response.add(CategoryModel.fromJson(element));
        });
      }

      return response;
    } catch (e) {
      throw (e);
    }
  }

  Future<CategoryModel?> postCategory(
    String code,
    String name,
  ) async {
    try {
      Map<String, dynamic> body = {
        "code": code,
        "name": name,
      };

      Response? resVal = await post("category/category-data", body);

      if (resVal!.statusCode == 200) {
        return CategoryModel.fromJson(resVal.data['data']);
      } else {
        var response = resVal.data['meta']['message'] ?? " terjadi kesalahan";
        return response;
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<CategoryModel?> editCategory(
    int id,
    String code,
    String name,
  ) async {
    try {
      Map<String, dynamic> body = {
        "code": code,
        "name": name,
      };
      Response? resVal = await post("category/update-data/$id", body);

      if (resVal!.statusCode == 200) {
        return CategoryModel.fromJson(resVal.data['data']);
      } else {
        var response = resVal.data['meta']['message'] ?? " terjadi kesalahan";
        return response;
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<String?> deleteCategory(
    String key,
  ) async {
    try {
      Map<String, dynamic> body = {};
      Response? resVal = await delete("category/delete-data/$key", body);
      if (resVal!.statusCode == 200) {
        return "1";
      } else {
        var response = resVal.data['meta']['message'] ?? " terjadi kesalahan";
        return response;
      }
    } catch (e) {
      throw (e);
    }
  }
}
