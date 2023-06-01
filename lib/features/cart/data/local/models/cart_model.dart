import 'dart:ui';

import 'package:bein_ecommerce/features/home/products/data/models/product_model.dart';

class CartModel {
  Product? product;

  int? quantity;

  CartModel({required this.product, required this.quantity});

  CartModel.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    product = json['productDto'] != null
        ? Product.fromJson(json['productDto'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quantity'] = quantity;
    if (this.product != null) {
      data['productDto'] = this.product!.toJson();
    }
    return data;
  }
}

class Product {
  String? id;
  List<Images>? images;
  String? title;
  double? price;
  double? cashDiscount;
  int? quantity;
  double? discount;
  String? disc;

  Ar? ar;

  En? en;

  Product({
    required this.id,
    required this.quantity,
    required this.discount,
    required this.title,
    required this.cashDiscount,
    required this.price,
    required this.images,
    required this.disc,
    required this.ar,
    required this.en,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];

    price = json['price'];
    discount = json['discount'];
    cashDiscount = json['cashDiscount'];
    quantity = json['quantity'];
    disc = json['description'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    ar = json['ar'] != null ? Ar.fromJson(json['ar']) : null;
    en = json['data'] != null ? En.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    data['price'] = price;
    data['discount'] = discount;
    data['cashDiscount'] = cashDiscount;
    data['quantity'] = quantity;
    data['description'] = disc;
    if (this.ar != null) {
      data['ar'] = this.ar!.toJson();
    }
    if (this.en != null) {
      data['data'] = this.en!.toJson();
    }
    return data;
  }
}

class En {
  String? title;
  String? description;
  Map<String, dynamic>? details;

  En({this.title, this.description, this.details});

  En.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    details = json['details'] ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['details'] = details;
    return data;
  }
}

class Ar {
  String? title;
  String? description;
  Map<String, dynamic>? details;

  Ar({this.title, this.description, this.details});

  Ar.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    details = json['details'] ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['details'] = details;
    return data;
  }
}
