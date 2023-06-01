class ProductModel {
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
  double? rateAverage;
  En? en ;
  Ar? ar ;

  ProductModel(
      {this.id,
        this.vendorName,
        this.vendorId,
        this.price,
        this.discount,
        this.cashDiscount,
        this.data,
        this.images,
        this.videos,
        this.rates,
        this.rateAverage,
        this.en,
        this.ar});

  ProductModel.fromJson(Map<String, dynamic>  json) {
    id = json['id'];
    vendorName = json['vendorName'];
    vendorId = json['vendorId'];
    price = json['price'];
    discount = json['discount'];
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
    rates = json['rates']??[];
    rateAverage = json['rateAverage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['vendorName'] = vendorName;
    data['vendorId'] = vendorId;
    data['price'] = price;
    data['discount'] = discount;
    data['cashDiscount'] = cashDiscount;
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

class Data {
  String? title;
  String? description;
  Map<String , dynamic>? details;
  

  Data({this.title, this.description, this.details});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    details = json['details'] ?? [] ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['details'] = details ;
    return data;
  }
}

class Images {
  String? id;
  String? fileName;
  String? url;

  Images({this.id, this.fileName, this.url});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fileName = json['fileName'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fileName'] = fileName;
    data['url'] = url;
    return data;
  }
}

class Videos {
  String? id;
  String? fileName;
  String? url;

  Videos({this.id, this.fileName, this.url});

  Videos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fileName = json['fileName'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fileName'] = fileName;
    data['url'] = url;
    return data;
  }
}


class En {
  String? title;
  String? description;
  Map<String , dynamic>? details;

  En({this.title, this.description, this.details});

  En.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    details = json['details'] ?? [] ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['details'] = details ;
    return data;
  }
  
}

class Ar {
  String? title;
  String? description;
  Map<String , dynamic>? details;

  Ar({this.title, this.description, this.details});

  Ar.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    details = json['details'] ?? [] ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['details'] = details ;
    return data;
  }

}


