import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phynd_app/presentation/widgets/buttons/secondary_button.dart';

void main() {
  testWidgets('SecondaryButton renders correctly with default properties',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SecondaryButton(
            text: 'Test Button',
            onPressed: () {},
          ),
        ),
      ),
    );

    expect(find.text('Test Button'), findsOneWidget);
    expect(find.byType(OutlinedButton), findsOneWidget);
  });

  testWidgets('SecondaryButton handles onPressed callback',
      (WidgetTester tester) async {
    bool pressed = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SecondaryButton(
            text: 'Test Button',
            onPressed: () => pressed = true,
          ),
        ),
      ),
    );

    await tester.tap(find.byType(SecondaryButton));
    await tester.pump();
    expect(pressed, true);
  });

  testWidgets('SecondaryButton shows loading indicator when isLoading is true',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SecondaryButton(
            text: 'Test Button',
            onPressed: () {},
            isLoading: true,
          ),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Test Button'), findsNothing);
  });

  testWidgets('SecondaryButton respects custom width and height',
      (WidgetTester tester) async {
    const customWidth = 200.0;
    const customHeight = 60.0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SecondaryButton(
            text: 'Test Button',
            onPressed: () {},
            isFullWidth: false,
            width: customWidth,
            height: customHeight,
          ),
        ),
      ),
    );

    final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
    expect(sizedBox.width, customWidth);
    expect(sizedBox.height, customHeight);
  });

  testWidgets('SecondaryButton is disabled when onPressed is null',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SecondaryButton(
            text: 'Test Button',
            onPressed: () {},
            isLoading: true,
          ),
        ),
      ),
    );

    final button = tester.widget<OutlinedButton>(find.byType(OutlinedButton));
    expect(button.onPressed, null);
  });

  testWidgets('SecondaryButton has correct border radius',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SecondaryButton(
            text: 'Test Button',
            onPressed: () {},
          ),
        ),
      ),
    );

    final button = tester.widget<OutlinedButton>(find.byType(OutlinedButton));
    final style = button.style as ButtonStyle;
    final shape = style.shape?.resolve({}) as RoundedRectangleBorder;
    expect(shape.borderRadius, BorderRadius.circular(8));
  });
}
