class OnBoardingModel {
  /*"id": "67555d0c-73f9-4ac7-8f13-b333b0961200",
    "enImages": [
        {
            "id": "647da27084f74c30330c0417",
            "fileName": "115304_05062023_30851.jpg",
            "type": "en",
            "url": "http://192.168.100.50:8080/api/show?name=115304_05062023_30851.jpg"
        }
    ],
    "arImages": []*/
  String? id;

  List<Imgs>? images;

  OnBoardingModel({this.id, this.images});

  OnBoardingModel.fromJson(Map<String, dynamic> json) {
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
