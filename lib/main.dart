import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streaks/core/config/locator.dart';
import 'package:streaks/data/providers/category_provider.dart';
import 'package:streaks/features/home_page/view/home_page_screen.dart';
import 'package:streaks/data/providers/habit_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await initializeApp();
  runApp(const MyApp());
}

Future<void> initializeApp() async {
  try {
    final habitProvider = locator<HabitProvider>();
    await habitProvider.fetchHabits();

    final categoryProvider = locator<CategoryProvider>();
    categoryProvider.initilizeCategories(habitProvider.habits);
  } catch (e) {
    debugPrint("Error during initialization: $e");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HabitProvider>(
          create: (_) => locator<HabitProvider>(),
        ),
        ChangeNotifierProvider<CategoryProvider>(
          create: (_) => locator<CategoryProvider>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Guten Morgen!'),
      ),
    );
  }
}
