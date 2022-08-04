import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:test_mobile_flutter/model/product_model.dart';
import 'package:test_mobile_flutter/services/api/api.dart';

class ApiProduct extends Api {
  Future<List<ProductModel?>?> getListProduct() async {
    try {
      Response? json = await get("post/get-all");
      List<ProductModel?>? response = [];
      if (json!.statusCode == 200) {
        var rawData = json.data['data'];
        rawData.forEach((element) {
          response.add(ProductModel.fromJson(element));
        });
      }

      return response;
    } catch (e) {
      throw (e);
    }
  }

  Future<ProductModel?> postProduct(
    String title,
    String slug,
    String category,
    String desc,
    File? file,
  ) async {
    try {
      Map<String, dynamic> body = {
        "title": title,
        "slug": slug,
        "category_id": category,
        "description": desc,
      };
      if (file != null) {
        String fileName = file.path.split('/').last;
        body['image'] =
            await MultipartFile.fromFile(file.path, filename: fileName);
      }

      Response? resVal =
          await post("post/post-data", body, mode: ModeParamRequest.FormData);

      if (resVal!.statusCode == 200) {
        log(resVal.data['data'].toString());
        return ProductModel.fromJson(resVal.data['data']);
      } else {
        var response = resVal.data;
        return response;
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<ProductModel?> editProduct(
    int id,
    String title,
    String slug,
    String category,
    String desc,
    File? file,
  ) async {
    try {
      Map<String, dynamic> body = {
        "title": title,
        "slug": slug,
        "category_id": category,
        "description": desc,
      };
      Response? resVal = await post("post/update-data/$id", body,
          mode: ModeParamRequest.FormData);

      if (resVal!.statusCode == 200) {
        return ProductModel.fromJson(resVal.data['data']);
      } else {
        var response = resVal.data;
        return response;
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<String?> deleteProduct(
    String key,
  ) async {
    try {
      Map<String, dynamic> body = {};
      Response? resVal = await delete("post/delete-data/$key", body);
      if (resVal!.statusCode == 200) {
        return "1";
      } else {
        var response = resVal.data;
        return response;
      }
    } catch (e) {
      throw (e);
    }
  }
}
