import 'package:flutter/material.dart';
import 'package:packages_flutter/core/offiline/pref_utils.dart';
import 'package:provider/provider.dart';

import 'package:packages_flutter/core/viewModels/providers.dart';
import 'package:packages_flutter/helpers/helpers_export.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PrefUtils.init();

  runApp(
    MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: CustomTheme.mainTheme,
        initialRoute:
            PrefUtils.isLoggedIn ? RouteNames.homeRoute : RouteNames.loginRoute,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    ),
  );
}
