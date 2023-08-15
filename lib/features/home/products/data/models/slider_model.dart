class OffersModel {

  

  List<Imgs>? images;

  OffersModel({this.images});

  OffersModel.fromJson(Map<String, dynamic> json) {
    
    if (json['enImages'] != null) {
      images = <Imgs>[];
      json['enImages'].forEach((v) {
        images!.add(Imgs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    
    if (images != null) {
      data['enImages'] = images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Imgs {
  int? id;

  String? url;

  Imgs({required this.id, required this.url});

  Imgs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = url;
    return data;
  }
}
