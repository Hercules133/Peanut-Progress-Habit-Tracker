import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:streaks/features/settings_page/view/settings_page.dart';
import 'package:streaks/features/settings_page/view/switch_state.dart';

void main() {
  testWidgets('Settings Widget has all needed texts', (WidgetTester tester) async {
    final switchState = SwitchState();
    await tester.pumpWidget( ChangeNotifierProvider<SwitchState>(
        create: (context) => switchState,
        child: const MaterialApp(
          home: SettingsPage(),
        ),
      ),
    );

    expect(find.widgetWithText(AppBar,"Settings"), findsOneWidget); 
    expect(find.byIcon(Icons.person_outline), findsOne); 
    expect(find.text("Username"), findsOne);
    expect(find.text("Type in your name"), findsOne);
    expect(find.text("Languages"), findsOne);
    expect(find.text("Language"), findsOne);
    expect(find.text("Deutsch"), findsOne);
    expect(find.text("English"), findsOne);
    expect(find.text("Cloud"), findsOne);
    expect(find.text("None"), findsOne);
    expect(find.text("Theme Mode"), findsOne);
    expect(find.text("Theme"), findsOne);
    expect(find.text("Dark"), findsOne);
    expect(find.text("Light"), findsOne);
    expect(find.text("System"), findsExactly(2));
  });

  testWidgets("Settings Page has needed Elements", (WidgetTester tester) async {
    final switchState = SwitchState();
    await tester.pumpWidget( ChangeNotifierProvider<SwitchState>(
        create: (context) => switchState,
        child: const MaterialApp(
          home: SettingsPage(),
        ),
      ),
    );

    expect(find.byType(TextField), findsExactly(4)); 
    expect(find.byType(DropdownMenu<String>), findsExactly(2));

  });

  testWidgets("DropDownMenu 1 is working", (WidgetTester tester) async {
     final switchState = SwitchState();
    await tester.pumpWidget( ChangeNotifierProvider<SwitchState>(
        create: (context) => switchState,
        child: const MaterialApp(
          home: SettingsPage(),
        ),
      ),
    );

    final dropdown= find.byKey(const ValueKey("dropdown1")); 

    await tester.tap(dropdown); 
    await tester.pumpAndSettle();

    final dropdownItem= find.text("Deutsch").last; 

    await tester.tap(dropdownItem) ;
    await tester.pumpAndSettle(); 

    await tester.tap(dropdown); 
    await tester.pumpAndSettle();
    final dropdownItem2= find.text("English").last;
    await tester.tap(dropdownItem2) ;
    await tester.pumpAndSettle();

    expect(dropdown, findsOneWidget); 
    expect(dropdownItem, findsOne);
    expect(dropdownItem2, findsOneWidget); 
  }); 

  testWidgets("DropDownMenu2 is working", (WidgetTester tester) async {
     final switchState = SwitchState();
    await tester.pumpWidget( ChangeNotifierProvider<SwitchState>(
        create: (context) => switchState,
        child: const MaterialApp(
          home: SettingsPage(),
        ),
      ),
    );

    final dropdown= find.byKey(const ValueKey("dropdown2")); 

    await tester.tap(dropdown); 
    await tester.pumpAndSettle();

    final dropdownItem= find.text("Dark").last; 

    await tester.tap(dropdownItem) ;
    await tester.pumpAndSettle(); 

    await tester.tap(dropdown); 
    await tester.pumpAndSettle();
    final dropdownItem2= find.text("Light").last;
    await tester.tap(dropdownItem2) ;
    await tester.pumpAndSettle();

    await tester.tap(dropdown); 
    await tester.pumpAndSettle();
    final dropdownItem3= find.text("System").last;
    await tester.tap(dropdownItem3) ;
    await tester.pumpAndSettle();

    expect(dropdown, findsOneWidget); 
    expect(dropdownItem, findsOne);
    expect(dropdownItem2, findsOneWidget); 
    expect(dropdownItem3, findsOneWidget); 
  }); 



}