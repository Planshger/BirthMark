import 'dart:async';
import 'package:birthmark/features/wishes/domain/entities/wish.dart';
import 'package:birthmark/features/wishes/domain/usecases/add_wish.dart';
import 'package:birthmark/features/wishes/domain/usecases/delete_wish.dart';
import 'package:birthmark/features/wishes/domain/usecases/get_wishes.dart';
import 'package:birthmark/features/wishes/domain/usecases/update_wish.dart';
import 'package:birthmark/features/wishes/domain/usecases/watch_wishes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repositories/wish_repository.dart';
import 'wish_event.dart';
import 'wish_state.dart';


class _WishesUpdated extends WishEvent {
  final List<Wish> wishes;
  _WishesUpdated(this.wishes);
}

@injectable
class WishBloc extends Bloc<WishEvent, WishState> {
  final WishRepository repository;
  final AddWish addWish;
  final UpdateWish updateWish;
  final DeleteWish deleteWish;
  final GetWishes getWishes;
  final WatchWishes watchWishes;
  StreamSubscription? _wishSubscription;

  WishBloc(this.repository, this.addWish, this.updateWish, this.deleteWish, this.getWishes, this.watchWishes) : super(WishInitial()) {
    on<LoadWishes>(_onLoad);
    on<AddWishEvent>(_onAdd);
    on<UpdateWishEvent>(_onUpdate);
    on<DeleteWishEvent>(_onDelete);
    on<_WishesUpdated>((event, emit) => emit(WishesLoaded(event.wishes)));

    _wishSubscription = watchWishes().listen((wishes) {
      if (!isClosed) add(_WishesUpdated(wishes));
    });
  }

  Future<void> _onLoad(LoadWishes event, Emitter<WishState> emit) async {
    emit(WishLoading());
    try {
      final wishes = await getWishes(forceRefresh: event.forceRefresh);
      emit(WishesLoaded(wishes));
    } catch (e) {
      emit(WishError(e.toString()));
    }
  }

  Future<void> _onAdd(AddWishEvent event, Emitter<WishState> emit) async {
    try {
      await addWish(event.wish);
      // Состояние обновится автоматически через подписку на поток.
    } catch (e) {
      emit(WishError(e.toString()));
    }
  }

  Future<void> _onUpdate(UpdateWishEvent event, Emitter<WishState> emit) async {
    try {
      await updateWish(event.wish);
      // Состояние обновится автоматически через подписку на поток.
    } catch (e) {
      emit(WishError(e.toString()));
    }
  }

  Future<void> _onDelete(DeleteWishEvent event, Emitter<WishState> emit) async {
    try {
      await deleteWish(event.id);
      // Состояние обновится автоматически через подписку на поток.
    } catch (e) {
      emit(WishError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _wishSubscription?.cancel();
    return super.close();
  }
}