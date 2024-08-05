// To parse this JSON data, do
//ProductsModel
//     final ProductsModel = ProductsModelFromJson(jsonString);
// To parse this JSON data, do
//     final ProductsModel = ProductsModelFromJson(jsonString);

import 'dart:convert';

ProductsModel ProductsModelFromJson(String str) => ProductsModel.fromJson(json.decode(str));

String ProductsModelToJson(ProductsModel data) => json.encode(data.toJson());

class ProductsModel {
  final List<Product>? products;
  final int? total;

  ProductsModel({
    this.products,
    this.total,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
    products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
    "total": total,
  };
}

class Product {
  final int? id;
  final String? title;
  final double? price;
  final List<String>? images;
  final Category? category;
  final String? description;
  final String? brand;

  Product({
    this.id,
    this.title,
    this.price,
    this.images,
    this.category,
    this.description,
    this.brand,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    title: json["title"],
    price: json["price"]?.toDouble(),
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    category: categoryValues.map[json["category"]]!,
    description: json["description"],
    brand: json["brand"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "category": categoryValues.reverse[category],
    "description": description,
    "brand": brand,
  };
}

enum Category {
  BEAUTY,
  FRAGRANCES,
  FURNITURE,
  GROCERIES
}

final categoryValues = EnumValues({
  "beauty": Category.BEAUTY,
  "fragrances": Category.FRAGRANCES,
  "furniture": Category.FURNITURE,
  "groceries": Category.GROCERIES
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
