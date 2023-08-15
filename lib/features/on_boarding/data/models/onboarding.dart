
class OnBoarding {
  String? title;
  String? desc;
  String? image;

  OnBoarding({required this.title, required this.desc, required this.image});

  OnBoarding.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    desc = json['desc'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['desc'] = desc;
    data['image'] = image;
    return data;
  }
}
