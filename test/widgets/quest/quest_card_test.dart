import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phynd_app/core/theme/app_colors.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/presentation/widgets/quest/quest_card.dart';

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

  testWidgets('QuestCard renders correctly with default properties',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          extensions: [appTheme],
        ),
        home: Scaffold(
          body: QuestCard(
            title: 'Test Quest',
            description: 'Test Description',
            reward: '100 Points',
          ),
        ),
      ),
    );

    expect(find.text('Test Quest'), findsOneWidget);
    expect(find.text('Test Description'), findsOneWidget);
    expect(find.text('100 Points'), findsOneWidget);
    expect(find.byType(Card), findsOneWidget);
    expect(find.byIcon(Icons.emoji_events), findsOneWidget);
  });

  testWidgets('QuestCard handles onTap callback', (WidgetTester tester) async {
    bool tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          extensions: [appTheme],
        ),
        home: Scaffold(
          body: QuestCard(
            title: 'Test Quest',
            description: 'Test Description',
            reward: '100 Points',
            onTap: () => tapped = true,
          ),
        ),
      ),
    );

    await tester.tap(find.byType(QuestCard));
    await tester.pump();
    expect(tapped, true);
  });

  testWidgets('QuestCard renders with custom icon and color',
      (WidgetTester tester) async {
    const customIcon = Icons.star;
    const customColor = Colors.blue;

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          extensions: [appTheme],
        ),
        home: Scaffold(
          body: QuestCard(
            title: 'Test Quest',
            description: 'Test Description',
            reward: '100 Points',
            icon: customIcon,
            iconColor: customColor,
          ),
        ),
      ),
    );

    expect(find.byIcon(customIcon), findsOneWidget);
    expect(find.byIcon(Icons.emoji_events), findsNothing);
  });

  testWidgets('QuestCard reward badge has correct styling',
      (WidgetTester tester) async {
    const reward = '100 Points';
    const iconColor = Colors.amber;

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          extensions: [appTheme],
        ),
        home: Scaffold(
          body: QuestCard(
            title: 'Test Quest',
            description: 'Test Description',
            reward: reward,
            iconColor: iconColor,
          ),
        ),
      ),
    );

    final rewardContainer = tester.widget<Container>(
      find.descendant(
        of: find.byType(QuestCard),
        matching: find.byType(Container).last,
      ),
    );

    final decoration = rewardContainer.decoration as BoxDecoration;
    expect(decoration.borderRadius, BorderRadius.circular(16));
    expect(decoration.color, iconColor.withOpacity(0.2));
  });

  testWidgets('QuestCard text styles are correct', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          extensions: [appTheme],
        ),
        home: Scaffold(
          body: QuestCard(
            title: 'Test Quest',
            description: 'Test Description',
            reward: '100 Points',
          ),
        ),
      ),
    );

    final titleText = tester.widget<Text>(find.text('Test Quest'));
    expect(titleText.style?.fontSize, 18);
    expect(titleText.style?.fontWeight, FontWeight.bold);

    final descriptionText = tester.widget<Text>(find.text('Test Description'));
    expect(descriptionText.style?.fontSize, 14);
    expect(
      descriptionText.style?.color,
      appTheme.get('text').withOpacity(0.7),
    );
  });
}
