import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

import 'core/functions/initial_route_function.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/app_starter.dart';
import 'core/utils/bloc_observer/bloc_observer_service.dart';
import 'core/utils/constants.dart';
import 'core/utils/di/di.dart';
import 'core/utils/routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppStarter.init();
  Bloc.observer = BlocObserverService(getIt<Logger>());
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale(Constants.ar), Locale(Constants.en)],
      path: Constants.assetsTranslations,
      startLocale: AppStarter.startLocale ?? const Locale(Constants.en),

      fallbackLocale: const Locale(Constants.en),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final RouteInitializer routeInitializer;

  @override
  void initState() {
    super.initState();
    routeInitializer = getIt<RouteInitializer>();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 910),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          title: 'Tracking Flower App',
          theme: AppTheme.appTheme,
          routes: AppRoutes.routes,
          initialRoute: routeInitializer.computeInitialRoute(),
          // initialRoute: routeInitializer.computeInitialRoute(),
        );
      },
    );
  }
}
