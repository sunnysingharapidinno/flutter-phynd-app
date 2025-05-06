import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phynd_app/core/theme/app_colors.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/presentation/widgets/buttons/primary_button.dart';

void main() {
  late AppTheme appTheme;

  setUp(() {
    appTheme = AppTheme({
      'bgColor': AppColors.platinum,
      'text': AppColors.black,
      'textSecondary': AppColors.textSecondaryLight,
      'primary': AppColors.primaryPurple,
      'secondary': AppColors.secondaryTeal,
      'tagBg': AppColors.translucentLavender,
      'cardBg': AppColors.cardLight,
      'accent': AppColors.accentGold,
      'textOnPrimary': AppColors.textOnPrimaryLight,
      'overlay': AppColors.overlayLight,
      'dividerColor': AppColors.dividerColorLight,
      'borderColor': AppColors.borderColorLight,
    });
  });

  testWidgets('PrimaryButton renders correctly with default properties',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          extensions: [appTheme],
        ),
        home: Scaffold(
          body: PrimaryButton(
            text: 'Test Button',
            onPressed: () {},
          ),
        ),
      ),
    );

    expect(find.text('Test Button'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('PrimaryButton handles onPressed callback',
      (WidgetTester tester) async {
    bool pressed = false;
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          extensions: [appTheme],
        ),
        home: Scaffold(
          body: PrimaryButton(
            text: 'Test Button',
            onPressed: () => pressed = true,
          ),
        ),
      ),
    );

    await tester.tap(find.byType(PrimaryButton));
    await tester.pump();
    expect(pressed, true);
  });

  testWidgets('PrimaryButton shows loading indicator when isLoading is true',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          extensions: [appTheme],
        ),
        home: Scaffold(
          body: PrimaryButton(
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

  testWidgets('PrimaryButton renders with transparent style',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          extensions: [appTheme],
        ),
        home: Scaffold(
          body: PrimaryButton(
            text: 'Test Button',
            onPressed: () {},
            isTransparent: true,
          ),
        ),
      ),
    );

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    final style = button.style as ButtonStyle;

    expect(
      style.backgroundColor?.resolve({}),
      Colors.transparent,
    );
  });

  testWidgets('PrimaryButton respects custom width and height',
      (WidgetTester tester) async {
    const customWidth = 200.0;
    const customHeight = 60.0;

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          extensions: [appTheme],
        ),
        home: Scaffold(
          body: PrimaryButton(
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

  testWidgets('PrimaryButton is disabled when onPressed is null',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          extensions: [appTheme],
        ),
        home: Scaffold(
          body: PrimaryButton(
            text: 'Test Button',
            onPressed: null,
          ),
        ),
      ),
    );

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, null);
  });
}
