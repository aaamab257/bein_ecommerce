class CategoryModel {
  List<CategoryItem>? categoryList;

  CategoryModel({required this.categoryList});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      categoryList = <CategoryItem>[];
      json['content'].forEach((v) {
        categoryList!.add(CategoryItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (categoryList != null) {
      data['content'] = categoryList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryItem {
  int? id;
  String? name;
  String? image;

  CategoryItem({
    required this.id,
    required this.image,
    required this.name,
  });

  CategoryItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image ;

    return data;
  }

  /* "id": "6457ae154faaf1598b054df4",
            "name": "Dental",
            "arName": "طب الاسنان",
            "status": "APPROVED",
            "createdDate": "2023-05-11T10:40:08.324+00:00" */
}
