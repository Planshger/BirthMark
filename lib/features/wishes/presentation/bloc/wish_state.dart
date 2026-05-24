import '../../domain/entities/wish.dart';

abstract class WishState {}

class WishInitial extends WishState {}

class WishLoading extends WishState {}

class WishesLoaded extends WishState {
  final List<Wish> wishes;
  WishesLoaded(this.wishes);
}

class WishError extends WishState {
  final String message;
  WishError(this.message);
}