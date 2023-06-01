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
  String? id;
  String? name;
  String? arName;
  String? status;
  String? createdDate;

  CategoryItem(
      {required this.id,
      required this.arName,
      required this.createdDate,
      required this.name,
      required this.status});

  CategoryItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    arName = json['arName'];
    status = json['status'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['arName'] = arName;
    data['status'] = status;
    data['createdDate'] = createdDate;
    return data;
  }

  /* "id": "6457ae154faaf1598b054df4",
            "name": "Dental",
            "arName": "طب الاسنان",
            "status": "APPROVED",
            "createdDate": "2023-05-11T10:40:08.324+00:00" */
}
