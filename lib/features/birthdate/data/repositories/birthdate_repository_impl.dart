import 'dart:async';
import 'package:birthmark/features/birthdate/data/models/birthdate_model.dart';
import 'package:birthmark/features/birthdate/domain/entities/birthdate.dart';
import 'package:birthmark/features/birthdate/domain/repositories/birthdate_repository.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';


@LazySingleton(as: BirthDateRepository)
class BirthdateRepositoryImpl extends BirthDateRepository {
  final Box<BirthDateModel> _box;
  final _controller = StreamController<List<BirthDateModel>>();
  late final StreamSubscription _boxSubscription;

  BirthdateRepositoryImpl(this._box) { 
    _controller.onListen = () => _controller.add(_box.values.toList());
    _boxSubscription = _box.watch().listen((event) => _controller.add(_box.values.toList()));
  }

  @override
  Stream<List<BirthDate>> watchBirthDates() {
    return _controller.stream.map((list) => list.map((e) => e.toEntity()).toList());
  }

  @override
  Future<List<BirthDate>> getBirthDates() async => _box.values.map((e) => e.toEntity()).toList();

  @override
  Future<void> addBirthDate(BirthDate birthDate) async {
    final date = BirthDateModel.toModel(birthDate);
    await _box.put(date.id, date);
  }

  @override
  Future<void> deleteBirthDate(String id) async {
    await _box.delete(id);
  }

  @override
  Future<void> updateBirthDate(BirthDate birthDate) async {
    final date = BirthDateModel.toModel(birthDate);
    await _box.put(date.id, date);
  }
  
  @override
  @disposeMethod
  void dispose() {
    _boxSubscription.cancel();
    _controller.close();
  }
}