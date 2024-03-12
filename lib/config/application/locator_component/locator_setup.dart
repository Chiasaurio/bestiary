import 'package:flutter/material.dart';

import '../../theme/colors_config.dart';
import '../../theme/theme_config.dart';
import 'locator_instance.dart';

void locatorSetupComponent(bool isProduction, String environmentName) {
  // locator.registerSingleton<EnvironmentApp>(
  //   EnvironmentApp(isProduction: isProduction, name: environmentName),
  // );

  locator.registerSingleton<ThemeAppConfig>(
    ThemeAppConfig(ColorsLightApp()),
    instanceName: 'light',
  );

  locator.registerSingleton<ThemeAppConfig>(
    ThemeAppConfig(ColorsDarkApp(), Brightness.dark),
    instanceName: 'dark',
  );

  // locator.registerLazySingletonAsync<Mixpanel>(
  //   () => AnaliticDependenies.initMixpanel(),
  // );

  // locator.registerSingleton<FirebaseAnalytics>(
  //   AnaliticDependenies.analytics,
  // );

  // locator.registerSingleton<FirebaseMessaging>(
  //   NotificationInstanceComponent.messaging,
  // );

  // locator.registerSingleton<FirebaseRemoteConfig>(
  //   FirebaseRemoteConfig.instance,
  // );

  // locator.registerSingleton<Logger>(
  //   LoggerInstanceComponent.get,
  // );

  // locator.registerSingleton<GlobalStore>(GlobalStore());
}
