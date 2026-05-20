import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class InjectionModule {
  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();

  @lazySingleton
  Dio get dio => Dio();

  @Named('baseUrl')
  String get baseUrl => 'http://10.190.168.164:3000/api'; 

  @preResolve
  @Named('prefs')
  Future<SharedPreferences> get sharedPrefs async => await SharedPreferences.getInstance();

  @preResolve
  @lazySingleton
  @Named('wishBox')
  Future<Box> get wishBox async => await Hive.openBox('wishes');

  @preResolve
  @lazySingleton
  @Named('categoryBox')
  Future<Box> get categoryBox async => await Hive.openBox('categories');

  @preResolve
  @lazySingleton
  @Named('occasionBox')
  Future<Box> get occasionBox async => await Hive.openBox('occasions');
}