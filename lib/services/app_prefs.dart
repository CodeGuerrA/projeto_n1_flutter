class AppPrefs {
  static bool _onboardingSkipped = false;

  static Future<void> init() async {
    // Simulação: nada a carregar, só memória
  }

  static bool get onboardingSkipped => _onboardingSkipped;

  static Future<void> setOnboardingSkipped(bool value) async {
    _onboardingSkipped = value;
  }
}
