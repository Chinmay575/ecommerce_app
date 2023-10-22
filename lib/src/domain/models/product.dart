import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  int id;
  String title;
  int price;
  String description;
  List<String> images;
  int categoryId;
  bool favorite;
  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.images,
    required this.categoryId,
    this.favorite = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'images': images,
      'categoryId': categoryId,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    List<String> images = [];
    for(var i in map['images'])
    {
      images.add(i);
    }
    return Product(
      id: map['id'] as int,
      title: map['title'] as String,
      price: map['price'] as int,
      description: map['description'] as String,
      images: images,
      categoryId: map['category']['id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
