import 'package:birthmark/features/birthdate/data/models/birthdate_model.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class SharedModule {
  @preResolve
  @lazySingleton
  Future<bool> initHive() async {
    try {
      await Hive.initFlutter();
      Hive.registerAdapter(BirthDateModelAdapter());
      return true;
    } catch (e) {
      return false;
    }
  }

  @preResolve
  @lazySingleton
  Future<Box<BirthDateModel>> provideBirthdatesBox() async {
    return await Hive.openBox<BirthDateModel>('birthdates');
  }

  @preResolve
  @lazySingleton
  Future<SharedPreferences> provideSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

}

