import 'package:birthmark/features/wishes/domain/entities/wish.dart';
import 'package:birthmark/features/wishes/domain/repositories/wish_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddWish {
  final WishRepository repository;
  AddWish(this.repository);
  Future<Wish> call(Wish wish) => repository.addWish(wish);
}