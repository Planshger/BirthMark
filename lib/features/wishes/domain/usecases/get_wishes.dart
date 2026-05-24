import 'package:injectable/injectable.dart';
import '../repositories/wish_repository.dart';
import '../entities/wish.dart';

@injectable
class GetWishes {
  final WishRepository repository;
  GetWishes(this.repository);
  Future<List<Wish>> call({bool forceRefresh = false}) => repository.getWishes(forceRefresh: forceRefresh);
}