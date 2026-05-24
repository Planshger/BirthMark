import 'package:birthmark/features/wishes/domain/entities/wish.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

part 'wish_model.g.dart';

@HiveType(typeId: 1)
class WishModel {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final double? price;

  @HiveField(3)
  final String? link;

  @HiveField(4)
  final int? categoryId;

  @HiveField(5)
  final int? occasionId;

  WishModel({this.id, required this.title, this.price, this.link, this.categoryId, this.occasionId});

  Wish toEntity() => Wish(
    id: id,
    title: title,
    price: price,
    link: link,
    categoryId: categoryId,
    occasionId: occasionId,
  );

  factory WishModel.fromEntity(Wish wish) => WishModel(
    id: wish.id,
    title: wish.title,
    price: wish.price,
    link: wish.link,
    categoryId: wish.categoryId,
    occasionId: wish.occasionId,
  );

}
