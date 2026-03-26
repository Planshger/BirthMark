class OnboardingItemModel {
  final String titleKey;
  final String descriptionKey;

  OnboardingItemModel({
    required this.titleKey,
    required this.descriptionKey,
  });

  factory OnboardingItemModel.fromJson(Map<String, dynamic> json) {
    return OnboardingItemModel(
      titleKey: json['titleKey'] as String,
      descriptionKey: json['descriptionKey'] as String,
    );
  }
}
