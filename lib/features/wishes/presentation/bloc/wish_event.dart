import '../../domain/entities/wish.dart';

abstract class WishEvent {}

class LoadWishes extends WishEvent {
  final bool forceRefresh;
  LoadWishes({this.forceRefresh = false});
}

class AddWishEvent extends WishEvent {
  final Wish wish;
  AddWishEvent(this.wish);
}

class UpdateWishEvent extends WishEvent {
  final Wish wish;
  UpdateWishEvent(this.wish);
}

class DeleteWishEvent extends WishEvent {
  final int id;
  DeleteWishEvent(this.id);
}
