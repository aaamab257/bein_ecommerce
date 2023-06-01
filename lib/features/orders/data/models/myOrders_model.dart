import '../../../home/products/data/models/product_model.dart';

class MyOrderModel {
  String? id;

  String? shippingAddress;

  String? orderStatus;

  String? payType;

  List<OrderItem>? orderItem;

  MyOrderModel(
      {required this.id,
      required this.shippingAddress,
      required this.orderStatus,
      required this.payType,
      required this.orderItem});

  MyOrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shippingAddress = json['shippingAddress'];
    orderStatus = json['orderStatus'];
    payType = json['paytype'];
    if (json['orderItems'] != null) {
      orderItem = <OrderItem>[];
      json['orderItems'].forEach((v) {
        orderItem!.add(OrderItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['shippingAddress'] = shippingAddress;
    data['orderStatus'] = orderStatus;
    data['paytype'] = payType;
    if (orderItem != null) {
      data['orderItems'] = orderItem!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderItem {
  OrderItemProduct? orderItemProduct;

  OrderItem({required this.orderItemProduct});

  OrderItem.fromJson(Map<String, dynamic> json) {
    orderItemProduct = json['product'] != null
        ? OrderItemProduct.fromJson(json['product'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orderItemProduct != null) {
      data['product'] = orderItemProduct!.toJson();
    }
    return data;
  }
}

class OrderItemProduct {
  String? id;
  String? vendorName;
  String? vendorId;
  double? price;
  double? discount;
  double? cashDiscount;
  Data? data;
  List<Images>? images;
  List<Videos>? videos;
  List? rates;
  String? status;
  String? createdDate ;

  double? rateAverage;
  En? en;

  Ar? ar;

  OrderItemProduct(
      {this.id,
        this.createdDate ,
      this.vendorName,
      this.vendorId,
      this.price,
      this.discount,
      this.cashDiscount,
      this.data,
      this.images,
      this.status,
      this.videos,
      this.rates,
      this.rateAverage,
      this.en,
      this.ar});

  OrderItemProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorName = json['vendorName'];
    createdDate = json['createdDate'];
    vendorId = json['vendorId'];
    price = json['price'];
    discount = json['discount'];
    status = json['status'];
    cashDiscount = json['cashDiscount'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    ar = json['ar'] != null ? Ar.fromJson(json['ar']) : null;
    en = json['en'] != null ? En.fromJson(json['en']) : null;
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    if (json['videos'] != null) {
      videos = <Videos>[];
      json['videos'].forEach((v) {
        videos!.add(Videos.fromJson(v));
      });
    }
    rates = json['rates'] ?? [];
    rateAverage = json['rateAverage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdDate'] = createdDate ;
    data['vendorName'] = vendorName;
    data['vendorId'] = vendorId;
    data['price'] = price;
    data['discount'] = discount;
    data['cashDiscount'] = cashDiscount;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.data != null) {
      data['ar'] = this.ar!.toJson();
    }
    if (this.data != null) {
      data['en'] = this.en!.toJson();
    }
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    if (videos != null) {
      data['videos'] = videos!.map((v) => v.toJson()).toList();
    }
    if (rates != null) {
      data['rates'] = rates!.map((v) => v.toJson()).toList();
    }
    data['rateAverage'] = rateAverage;
    return data;
  }
}
