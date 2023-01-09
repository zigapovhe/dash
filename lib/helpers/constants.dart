class Constants {
  static const int minPasswordLength = 8;

  // Local Storage Keys
  static const String firstLoginKey = 'firstLogin';
  static const String userObjectKey = 'userObject';

  static const String loginName = "Prijava";
  static const String loginRoute = "/login";

  static const String registerName = "Registracija";
  static const String registerRoute = "/register";

  static const String onboardingScreenName = "OnBoardingScreen";
  static const String onboardingRoute = "/onboarding";

  static const String dashboardName = ".";
  static const String dashboardRoute = "/dashboard";

  static const String detailedChatName = "Klepet";
  static const String detailedChatRoute = "/dashboard/$chatRoute";
  static const String chatRoute = "chat";

  static const String createChatName = "Začni nov klepet";
  static const String createChatRoute = "/create-chat";

  static const String profileName = "Profil";
  static const String profileRoute = "/profile";

  static const String forgotPasswordName = "Pozabljeno geslo";
  static const String forgotPasswordRoute = "/forgot-password";
}
