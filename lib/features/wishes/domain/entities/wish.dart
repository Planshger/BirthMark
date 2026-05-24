class Wish {
  final int? id;
  final String title;
  final double? price;
  final String? link;
  final int? categoryId;
  final int? occasionId;

  Wish({
    this.id,
    required this.title,
    this.price,
    this.link,
    this.categoryId,
    this.occasionId,
  });

  Wish copyWith({
    int? id,
    String? title,
    double? price,
    String? link,
    int? categoryId,
    int? occasionId,
  }) {
    return Wish(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      link: link ?? this.link,
      categoryId: categoryId ?? this.categoryId,
      occasionId: occasionId ?? this.occasionId,
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'price': price,
    'link': link,
    'categoryId': categoryId,
    'occasionId': occasionId,
  };

}
