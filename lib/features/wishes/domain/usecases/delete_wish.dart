import 'package:birthmark/features/wishes/domain/repositories/wish_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteWish {
  final WishRepository repository;
  DeleteWish(this.repository);
  Future<void> call(int id) => repository.deleteWish(id);
}