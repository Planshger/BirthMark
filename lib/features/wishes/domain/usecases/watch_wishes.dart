import 'package:birthmark/features/wishes/domain/entities/wish.dart';
import 'package:birthmark/features/wishes/domain/repositories/wish_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class WatchWishes {
  final WishRepository repository;
  WatchWishes(this.repository);
  Stream<List<Wish>> call() => repository.watchWishes();

}