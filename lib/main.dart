import 'package:flutter/material.dart';
import 'package:packages_flutter/helpers/theme/dark.dart';
import 'package:packages_flutter/helpers/theme/light.dart';
import 'package:packages_flutter/helpers/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: ThemeManager())],
      child: Consumer<ThemeManager>(
        builder: (_, theme, __) {
          return MaterialApp(
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: theme.themeMode,
            // themeMode: ThemeMode.system, // use this for system theme
            home: const Home(),
          );
        },
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theming in flutter'),
        actions: [
          IconButton(
            onPressed: context.read<ThemeManager>().toggleTheme,
            icon: Icon(
              context.watch<ThemeManager>().isDark
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
            ),
          ),
        ],
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(onPressed: () {}, child: const Text('Text Button')),
          OutlinedButton(
              onPressed: () {}, child: const Text('Outlined Button')),
          ElevatedButton(onPressed: () {}, child: const Text('Elevated Button'))
        ],
      )),
    );
  }
}
