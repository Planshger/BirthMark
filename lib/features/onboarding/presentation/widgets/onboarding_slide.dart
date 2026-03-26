import 'package:birthmark/features/onboarding/domain/entities/onboarding_item.dart';
import 'package:flutter/cupertino.dart';

class OnboardingSlide extends StatelessWidget {
  final OnboardingItem item;

  const OnboardingSlide({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1)),
            child: Text(
              _resolve(item.titleKey),
              maxLines: 3,
              style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle.copyWith(fontSize: 28),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 30),
          MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(0.85)),
            child: Text(
              _resolve(item.descriptionKey),
              style: TextStyle(fontSize: 18, color: CupertinoColors.systemGrey),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  String _resolve(String key) {
    switch (key) {
      case 'onboarding_title1':
        return "Добро пожаловать в BirthMark!";
      case 'onboarding_title2':
        return "Легко добавляйте даты";
      case 'onboarding_title3':
        return "Умные напоминания";
      case 'onboarding_title4':
        return "Готовы праздновать?";
      case 'onboarding_description1':
        return "Больше ни одного пропущенного дня рождения. Мы поможем вам помнить и отмечать важные даты ваших близких.";
      case 'onboarding_description2':
        return "Быстро вносите имена и дни рождения. Добавляйте их вручную или импортируйте из контактов для удобства.";
      case 'onboarding_description3':
        return "Получайте своевременные уведомления, чтобы у вас было достаточно времени для подготовки подарка или тёплых поздравлений.";
      case 'onboarding_description4':
        return "Давайте начнём! Добавьте первый день рождения и сделайте чей-то день особенным.";
      default:
        return key;
    }
  }
}
