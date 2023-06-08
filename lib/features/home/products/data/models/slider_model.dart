class OffersModel {

  String? id;

  List<Imgs>? images;

  OffersModel({this.id, this.images});

  OffersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['enImages'] != null) {
      images = <Imgs>[];
      json['enImages'].forEach((v) {
        images!.add(Imgs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (images != null) {
      data['enImages'] = images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Imgs {
  String? id;

  String? url;

  Imgs({required this.id, required this.url});

  Imgs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    return data;
  }
}
