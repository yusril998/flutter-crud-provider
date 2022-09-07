import 'package:crud_mobile_flutter/model/category_model.dart';

class ProductModel {
  int? id;
  String? title;
  String? slug;
  String? image;
  String? description;
  String? categoryId;
  String? createdAt;
  String? updatedAt;
  CategoryModel? getCategory;

  ProductModel(
      {this.id,
      this.title,
      this.slug,
      this.image,
      this.description,
      this.categoryId,
      this.createdAt,
      this.updatedAt,
      this.getCategory});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    image = json['image'];
    description = json['description'];
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    getCategory = json['get_category'] != null
        ? new CategoryModel.fromJson(json['get_category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['image'] = this.image;
    data['description'] = this.description;
    data['category_id'] = this.categoryId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.getCategory != null) {
      data['get_category'] = this.getCategory!.toJson();
    }
    return data;
  }
}
