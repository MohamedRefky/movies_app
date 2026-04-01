import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies_app/movies/presentation/screens/main_screen.dart';
import 'core/services/services_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ServicesLocator().init();
  await Hive.initFlutter();
  await Hive.openBox<int>('favoritesBox');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies App',
      theme: ThemeData.dark().copyWith(
        splashFactory: NoSplash.splashFactory,
        scaffoldBackgroundColor: Colors.grey.shade900,
      ),
      home: MainScreeen(),
    );
  }
}
