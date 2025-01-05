import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:peanutprogress/core/config/locator.dart';
import 'package:peanutprogress/core/utils/enums/day_of_week.dart';
import 'package:peanutprogress/core/utils/enums/progress_status.dart';
import 'package:peanutprogress/core/utils/routes.dart';
import 'package:peanutprogress/core/widgets/details_dialog_heatmap_widget.dart';
import 'package:peanutprogress/core/widgets/details_dialog_widget.dart';
import 'package:peanutprogress/data/models/habit.dart';
import 'package:peanutprogress/data/models/category.dart';
import 'package:peanutprogress/data/models/theme.dart';
import 'package:peanutprogress/data/providers/category_provider.dart';
import 'package:peanutprogress/data/providers/habit_provider.dart';
import 'package:peanutprogress/features/create_habit/view/create_habit_screen.dart';

class MockHabitProvider extends Mock implements HabitProvider {}

void main() {
  setUpAll(() {
    SharedPreferences.setMockInitialValues({});
    setupLocator();
  });

  final mockHabit = Habit(
    id: 1,
    title: 'mockHabit',
    description: 'This is a habit for testing',
    days: [DayOfWeek.friday],
    progress: {
      DateTime(2024, 12, 12): ProgressStatus.completed,
      DateTime(2024, 12, 13): ProgressStatus.notCompleted
    },
    category: Category.defaultCategory(),
    time: const TimeOfDay(hour: 12, minute: 12),
  );

  testWidgets('HabitDetailsDialog displays habit information',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider<HabitProvider>(
        create: (context) => locator<HabitProvider>(),
        child: MaterialApp(
          theme: lightMode,
          darkTheme: darkMode,
          home: Scaffold(
            body: HabitDetailsDialog(habit: mockHabit),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('mockHabit'), findsOneWidget);
    expect(find.text('This is a habit for testing'), findsOneWidget);
    expect(find.text('12:12'), findsOneWidget);
    expect(find.text('0'), findsOneWidget); // Assuming streak is 0
    expect(find.byType(MyHeatMap), findsOneWidget);
    expect(find.text(Category.defaultCategory().name), findsOneWidget);
    expect(find.byIcon(Category.defaultCategory().icon), findsOne);
  });

  testWidgets('HabitDetailsDialog toggle habit complete works',
      (WidgetTester tester) async {
    final habitProvider = MockHabitProvider();

    when(() => habitProvider.toggleHabitComplete(mockHabit, any()))
        .thenAnswer((_) async {
      mockHabit.toggleComplete(DateTime.now());
      habitProvider.notifyListeners();
    });

    await tester.pumpWidget(
      ChangeNotifierProvider<HabitProvider>(
        create: (context) => habitProvider,
        child: MaterialApp(
          theme: lightMode,
          darkTheme: darkMode,
          home: Scaffold(
            body: HabitDetailsDialog(habit: mockHabit),
          ),
        ),
      ),
    );

    final toggleButton = find.widgetWithImage(
        IconButton, const AssetImage('assets/images/Erdnuss.png'));

    expect(
        find.widgetWithImage(
            IconButton, const AssetImage('assets/images/Erdnuss.png')),
        findsOneWidget);
    await tester.tap(toggleButton);
    await tester.pumpAndSettle();

    verify(() => habitProvider.toggleHabitComplete(mockHabit, any())).called(1);
  });

  testWidgets('HabitDetailsDialog edit button navigates to edit page',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<HabitProvider>(
            create: (context) => locator<HabitProvider>(),
          ),
          ChangeNotifierProvider<CategoryProvider>(
            create: (context) => locator<CategoryProvider>(),
          ),
        ],
        child: MaterialApp(
          theme: lightMode,
          darkTheme: darkMode,
          routes: {
            Routes.edit: (context) => CreateHabit(newHabit: true,),
          },
          home: Scaffold(
            body: HabitDetailsDialog(habit: mockHabit),
          ),
        ),
      ),
    );

    final editButton = find.byIcon(Icons.edit);
    await tester.tap(editButton);
    await tester.pumpAndSettle();

    expect(find.byType(CreateHabit), findsOne);
  });
}
