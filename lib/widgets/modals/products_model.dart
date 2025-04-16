import 'package:moon_store/widgets/variables/variables.dart';

class ProductModel {
  final String id;
  final String image;
  final String brandName;
  final String title;
  final double price;
  final double? priceAfterDiscount;
  final int? discountPercent;
  int quantity;

  ProductModel({
    required this.id,
    required this.image,
    required this.brandName,
    required this.title,
    required this.price,
    this.priceAfterDiscount,
    this.discountPercent,
    this.quantity = 1,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      image: json['image'],
      brandName: json['brandName'],
      title: json['title'],
      price: json['price'].toDouble(),
      priceAfterDiscount: json['priceAfterDiscount']?.toDouble(),
      discountPercent: json['discountPercent'],
      quantity: json['quantity'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'brandName': brandName,
      'title': title,
      'price': price,
      'priceAfterDiscount': priceAfterDiscount,
      'discountPercent': discountPercent,
      'quantity': quantity,
    };
  }

  ProductModel copyWith({
    String? id,
    String? image,
    String? brandName,
    String? title,
    double? price,
    double? priceAfterDiscount,
    int? discountPercent,
    int? quantity,
  }) {
    return ProductModel(
      id: id ?? this.id,
      image: image ?? this.image,
      brandName: brandName ?? this.brandName,
      title: title ?? this.title,
      price: price ?? this.price,
      priceAfterDiscount: priceAfterDiscount ?? this.priceAfterDiscount,
      discountPercent: discountPercent ?? this.discountPercent,
      quantity: quantity ?? this.quantity,
    );
  }

  double get calculatedPrice => price * quantity;
  double? get calculatedDiscountPrice => 
      priceAfterDiscount != null ? priceAfterDiscount! * quantity : null;

  bool get hasDiscount => discountPercent != null && discountPercent! > 0;
}

final List<ProductModel> demoPopularProducts = [
  ProductModel(
    id: '1',
    image: productDemoImg1,
    title: "Mountain Warehouse for Women",
    brandName: "Lipsy london",
    price: 540,
    priceAfterDiscount: 420,
    discountPercent: 20,
  ),
  ProductModel(
    id: '2',
    image: productDemoImg4,
    title: "Mountain Beta Warehouse",
    brandName: "Lipsy london",
    price: 800,
  ),
  ProductModel(
    id: '3',
    image: productDemoImg5,
    title: "FS - Nike Air Max 270 Really React",
    brandName: "Lipsy london",
    price: 650.62,
    priceAfterDiscount: 390.36,
    discountPercent: 40,
  ),
  ProductModel(
    id: '4',
    image: productDemoImg6,
    title: "Green Poplin Ruched Front",
    brandName: "Lipsy london",
    price: 1264,
    priceAfterDiscount: 1200.8,
    discountPercent: 5,
  ),
  ProductModel(
    id: '5',
    image: "https://i.imgur.com/tXyOMMG.png",
    title: "Green Poplin Ruched Front",
    brandName: "Lipsy london",
    price: 650.62,
    priceAfterDiscount: 390.36,
    discountPercent: 40,
  ),
  ProductModel(
    id: '6',
    image: "https://i.imgur.com/h2LqppX.png",
    title: "white satin corset top",
    brandName: "Lipsy london",
    price: 1264,
    priceAfterDiscount: 1200.8,
    discountPercent: 5,
  ),
];

final List<ProductModel> demoFlashSaleProducts = [
  ProductModel(
    id: '7',
    image: productDemoImg5,
    title: "FS - Nike Air Max 270 Really React",
    brandName: "Lipsy london",
    price: 650.62,
    priceAfterDiscount: 390.36,
    discountPercent: 40,
  ),
  ProductModel(
    id: '8',
    image: productDemoImg6,
    title: "Green Poplin Ruched Front",
    brandName: "Lipsy london",
    price: 1264,
    priceAfterDiscount: 1200.8,
    discountPercent: 5,
  ),
  ProductModel(
    id: '9',
    image: productDemoImg4,
    title: "Mountain Beta Warehouse",
    brandName: "Lipsy london",
    price: 800,
    priceAfterDiscount: 680,
    discountPercent: 15,
  ),
];

final List<ProductModel> demoBestSellersProducts = [
  ProductModel(
    id: '10',
    image: "https://i.imgur.com/tXyOMMG.png",
    title: "Green Poplin Ruched Front",
    brandName: "Lipsy london",
    price: 650.62,
    priceAfterDiscount: 390.36,
    discountPercent: 40,
  ),
  ProductModel(
    id: '11',
    image: "https://i.imgur.com/h2LqppX.png",
    title: "white satin corset top",
    brandName: "Lipsy london",
    price: 1264,
    priceAfterDiscount: 1200.8,
    discountPercent: 5,
  ),
  ProductModel(
    id: '12',
    image: productDemoImg4,
    title: "Mountain Beta Warehouse",
    brandName: "Lipsy london",
    price: 800,
    priceAfterDiscount: 680,
    discountPercent: 15,
  ),
];

final List<ProductModel> kidsProducts = [
  ProductModel(
    id: '13',
    image: "https://i.imgur.com/dbbT6PA.png",
    title: "Green Poplin Ruched Front",
    brandName: "Lipsy london",
    price: 650.62,
    priceAfterDiscount: 590.36,
    discountPercent: 24,
  ),
  ProductModel(
    id: '14',
    image: "https://i.imgur.com/7fSxC7k.png",
    title: "Printed Sleeveless Tiered Swing Dress",
    brandName: "Lipsy london",
    price: 650.62,
  ),
  ProductModel(
    id: '15',
    image: "https://i.imgur.com/pXnYE9Q.png",
    title: "Ruffle-Sleeve Ponte-Knit Sheath",
    brandName: "Lipsy london",
    price: 400,
  ),
  ProductModel(
    id: '16',
    image: "https://i.imgur.com/V1MXgfa.png",
    title: "Green Mountain Beta Warehouse",
    brandName: "Lipsy london",
    price: 400,
    priceAfterDiscount: 360,
    discountPercent: 20,
  ),
  ProductModel(
    id: '17',
    image: "https://i.imgur.com/8gvE5Ss.png",
    title: "Printed Sleeveless Tiered Swing Dress",
    brandName: "Lipsy london",
    price: 654,
  ),
  ProductModel(
    id: '18',
    image: "https://i.imgur.com/cBvB5YB.png",
    title: "Mountain Beta Warehouse",
    brandName: "Lipsy london",
    price: 250,
  ),
];

class ProductCategory {
  final String id;
  final String name;
  final List<ProductModel> products;

  ProductCategory({
    required this.id,
    required this.name,
    required this.products,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      id: json['id'],
      name: json['name'],
      products: (json['products'] as List)
          .map((product) => ProductModel.fromJson(product))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'products': products.map((product) => product.toJson()).toList(),
    };
  }
}

final List<ProductCategory> productCategories = [
  ProductCategory(
    id: '1',
    name: 'Popular Products',
    products: demoPopularProducts,
  ),
  ProductCategory(
    id: '2',
    name: 'Flash Sale',
    products: demoFlashSaleProducts,
  ),
  ProductCategory(
    id: '3',
    name: 'Best Sellers',
    products: demoBestSellersProducts,
  ),
  ProductCategory(
    id: '4',
    name: 'Kids Products',
    products: kidsProducts,
  ),
];