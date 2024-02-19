import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, state, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const HomeScreen(),
          theme: state.isDarkMode ? darkMode : lightMode,
        ),
      ),
    );
  }
}

final lightMode = ThemeData.light().copyWith(
  appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
  scaffoldBackgroundColor: Colors.transparent,
  highlightColor: null,
);
final darkMode = ThemeData.light().copyWith(
  appBarTheme: const AppBarTheme(backgroundColor: Color(0xff010101)),
  scaffoldBackgroundColor: const Color(0xff010101),
);

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  set isDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }
}
