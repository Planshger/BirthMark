import 'package:birthmark/features/wishes/domain/entities/wish.dart';

abstract class WishRepository {
  Future<List<Wish>> getWishes({bool forceRefresh = false});
  Stream<List<Wish>> watchWishes();
  Future<Wish> addWish(Wish wish);
  Future<Wish> updateWish(Wish wish);
  Future<void> deleteWish(int id);
  void dispose();
}
