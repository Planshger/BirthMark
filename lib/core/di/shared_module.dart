import 'package:birthmark/features/wishes/data/models/wish_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class InjectionModule {
  @preResolve
  @lazySingleton
  Future<bool> initHive() async {
    try {
      await Hive.initFlutter();
      Hive.registerAdapter(WishModelAdapter());
      return true;
    } catch (_) {
      return false;
    }
  }

  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();

  @lazySingleton
  Dio get dio => Dio();

  @Named('baseUrl') // 10.190.168.164 // 127.0.0.1 // guise-impure-hydrogen.ngrok-free.dev
  String get baseUrl => 'http://127.0.0.1:3000/api';

  @preResolve
  @Named('prefs')
  Future<SharedPreferences> get sharedPrefs async => await SharedPreferences.getInstance();

  @preResolve
  @lazySingleton
  @Named('wishBox')
  Future<Box<WishModel>> get wishBox async => await Hive.openBox<WishModel>('wishes');

  @preResolve
  @lazySingleton
  @Named('categoryBox')
  Future<Box> get categoryBox async => await Hive.openBox('categories');

  @preResolve
  @lazySingleton
  @Named('occasionBox')
  Future<Box> get occasionBox async => await Hive.openBox('occasions');

}