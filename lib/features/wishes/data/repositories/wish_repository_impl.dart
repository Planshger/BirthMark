import 'dart:async';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/network/api_client.dart';
import '../../domain/entities/wish.dart';
import '../../domain/repositories/wish_repository.dart';
import '../models/wish_model.dart';

@LazySingleton(as: WishRepository)
class WishRepositoryImpl implements WishRepository {
  final ApiClient apiClient;
  final Box<WishModel> wishBox;
  final _controller = StreamController<List<Wish>>.broadcast();

  WishRepositoryImpl(this.apiClient, @Named('wishBox') this.wishBox) {
    wishBox.watch().listen((_) => _emitWishes());
    _emitWishes();
  }

  void _emitWishes() {
    final wishes = wishBox.values.map((m) => m.toEntity()).toList();
    _controller.add(wishes);
  }

  @override
  Stream<List<Wish>> watchWishes() => _controller.stream;

  @override
  Future<List<Wish>> getWishes({bool forceRefresh = false}) async {
    if (forceRefresh || wishBox.isEmpty) {
      await _fetchAndCache();
    }
    return wishBox.values.map((m) => m.toEntity()).toList();
  }

  Future<void> _fetchAndCache() async {
    final response = await apiClient.dio.get('/wishes');
    final List data = response.data;
    await wishBox.clear();
    for (final json in data) {
      final model = WishModel(
        id: json['id'],
        title: json['title'],
        price: (json['price'] as num?)?.toDouble(),
        link: json['link'],
        categoryId: json['category_id'],
        occasionId: json['occasion_id'],
      );
      await wishBox.put(model.id, model);
    }
  }

  @override
  Future<Wish> addWish(Wish wish) async {
    final response = await apiClient.dio.post('/wishes', data: wish.toJson());
    final json = response.data;
    final model = WishModel(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num?)?.toDouble(),
      link: json['link'],
      categoryId: json['category_id'],
      occasionId: json['occasion_id'],
    );
    await wishBox.put(model.id, model);
    return model.toEntity();
  }

  @override
  Future<Wish> updateWish(Wish wish) async {
    final response = await apiClient.dio.put('/wishes/${wish.id}', data: wish.toJson());
    final json = response.data;
    final model = WishModel(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num?)?.toDouble(),
      link: json['link'],
      categoryId: json['category_id'],
      occasionId: json['occasion_id'],
    );
    await wishBox.put(model.id, model);
    return model.toEntity();
  }

  @override
  Future<void> deleteWish(int id) async {
    await apiClient.dio.delete('/wishes/$id');
    await wishBox.delete(id);
  }

  @disposeMethod
  @override
  void dispose() {
    _controller.close();
  }
}