import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peanutprogress/core/widgets/app_bar_widget.dart';

void main() {
  testWidgets(
    'AppBar has all needed icons and text',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: MyAppBar(
              appBar: AppBar(),
              appBarTitle: 'Test AppBar',
            ),
          ),
        ),
      );
      expect(find.text('Test AppBar'), findsOneWidget);

      final logoFinder = find.byType(Image);
      expect(logoFinder, findsOneWidget);

      final Image logoImage = tester.widget<Image>(logoFinder);
      expect(logoImage.image, isA<AssetImage>());

      final AssetImage assetImage = logoImage.image as AssetImage;
      expect(assetImage.assetName, 'assets/images/logo.png');
    },
  );

  testWidgets(
    'AppBar has IconButtons',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: MyAppBar(
              appBar: AppBar(),
              appBarTitle: 'Test AppBar',
            ),
          ),
        ),
      );
      expect(find.byType(IconButton), findsExactly(2));
    },
  );

  testWidgets(
    'actions on IconButtons are correct',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: MyAppBar(
              appBar: AppBar(),
              appBarTitle: 'Test AppBar',
            ),
            drawer: const Drawer(),
          ),
        ),
      );
      expect(find.byType(Drawer), findsNothing);
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pump();
      expect(find.byType(Drawer), findsOneWidget);

      final imageButton = find.widgetWithImage(
          IconButton, const AssetImage('assets/images/logo.png'));

      final IconButton widget = tester.widget<IconButton>(imageButton);
      expect(widget.onPressed, isNull);
    },
  );
}
