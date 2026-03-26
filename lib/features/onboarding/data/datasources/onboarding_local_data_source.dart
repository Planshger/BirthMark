import 'dart:convert';
import 'package:birthmark/core/constants/preferences_keys.dart';
import 'package:birthmark/features/onboarding/data/models/onboarding_item_model.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class OnboardingLocalDataSource {
  Future<List<OnboardingItemModel>> loadItems();
  Future<bool> isCompleted();
  Future<void> markCompleted();
}

@LazySingleton(as: OnboardingLocalDataSource)
class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  final SharedPreferences prefs;
  OnboardingLocalDataSourceImpl(this.prefs);

  @override
  Future<List<OnboardingItemModel>> loadItems() async {
    final jsonString = await rootBundle.loadString('assets/data/onboarding_data.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((e) => OnboardingItemModel.fromJson(e)).toList();
  }

  @override
  Future<bool> isCompleted() async => prefs.getBool(PreferencesKeys.isOnboarded) ?? false;

  @override
  Future<void> markCompleted() async => prefs.setBool(PreferencesKeys.isOnboarded, true);
}
