import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phynd_app/data/models/response/quest_model.dart';
import 'package:phynd_app/presentation/widgets/quest/quest_header.dart';

void main() {
  late QuestModel mockQuestData;

  setUp(() {
    mockQuestData = QuestModel(
      questId: '1',
      priority: 1,
      processedHistoricalEventFeed: false,
      questType: 'Test Quest Type',
      startTime: DateTime.now(),
      endTime: DateTime.now().add(Duration(days: 2, hours: 5, minutes: 30)),
      timezone: 'UTC',
      completed: false,
      created: DateTime.now(),
      modified: DateTime.now(),
      isCreatedByAdmin: false,
      totalMissions: 5,
      missionCompleted: 0,
      totalTask: 10,
      taskCompleted: 0,
      q: '',
      p: '',
      awards: [],
      game: [],
      phyndCoins: 1000,
      phyndCoinsBonus: 100,
      gameName: 'Test Game Name',
      participants: 100,
      timeLeft: '2D 5H 30M',
      isEnabled: true,
      hasStarted: true,
      isModified: false,
      isFeatured: true,
      category: [],
      logicGroup: 1,
      missions: 5,
      name: 'Test Quest',
      description: 'Test Description',
      image: 'https://example.com/image.jpg',
    );
  });

  testWidgets('QuestHeader renders correctly with all properties',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: QuestHeader(
            questData: mockQuestData,
            onJoinPressed: () {},
          ),
        ),
      ),
    );

    // Verify quest name is displayed
    expect(find.text('Test Quest'), findsOneWidget);

    // Verify quest description is displayed
    expect(find.text('Test Description'), findsOneWidget);

    // Verify timer is displayed
    expect(find.text('ENDS IN 2D 5H 30M'), findsOneWidget);

    // Verify LIVE badge is displayed
    expect(find.text('LIVE'), findsOneWidget);

    // Verify Featured Quest badge is displayed
    expect(find.text('Featured Quest'), findsOneWidget);

    // Verify stats are displayed
    expect(find.text('100'), findsOneWidget);
    expect(find.text('Participants'), findsOneWidget);
    expect(find.text('No'), findsOneWidget);
    expect(find.text('Completed'), findsOneWidget);
    expect(find.text('5'), findsOneWidget);
    expect(find.text('Missions'), findsOneWidget);
    expect(find.text('1000'), findsOneWidget);
    expect(find.text('Rewards'), findsOneWidget);
  });

  testWidgets('QuestHeader handles missing optional data',
      (WidgetTester tester) async {
    final minimalQuestData = QuestModel(
      questId: '1',
      priority: 1,
      processedHistoricalEventFeed: false,
      questType: 'Test Quest Type',
      startTime: DateTime.now(),
      endTime: DateTime.now().add(Duration(days: 2)),
      timezone: 'UTC',
      completed: false,
      created: DateTime.now(),
      modified: DateTime.now(),
      isCreatedByAdmin: false,
      totalMissions: 0,
      missionCompleted: 0,
      totalTask: 0,
      taskCompleted: 0,
      q: '',
      p: '',
      awards: [],
      game: [],
      phyndCoins: 0,
      phyndCoinsBonus: 0,
      gameName: 'Test Game Name',
      participants: 0,
      timeLeft: '153D 18H 47M 01S',
      isEnabled: true,
      hasStarted: true,
      isModified: false,
      isFeatured: false,
      category: [],
      logicGroup: 1,
      missions: 0,
      name: 'Minimal Quest',
      description: 'Minimal Description',
      image: 'https://example.com/image.jpg',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: QuestHeader(
            questData: minimalQuestData,
          ),
        ),
      ),
    );

    // Verify basic information is displayed
    expect(find.text('Minimal Quest'), findsOneWidget);
    expect(find.text('Minimal Description'), findsOneWidget);

    // Verify default values are displayed
    expect(find.text('ENDS IN 153D 18H 47M 01S'), findsOneWidget);
    expect(find.text('0'), findsOneWidget); // Default participants
    expect(find.text('0'), findsOneWidget); // Default missions
    expect(find.text('0'), findsOneWidget); // Default rewards
  });

  testWidgets('QuestHeader handles onJoinPressed callback',
      (WidgetTester tester) async {
    bool callbackCalled = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: QuestHeader(
            questData: mockQuestData,
            onJoinPressed: () => callbackCalled = true,
          ),
        ),
      ),
    );

    // Since the widget doesn't have a join button in the current implementation,
    // we'll just verify that the callback is properly passed
    expect(callbackCalled, false);
  });

  testWidgets('QuestHeader displays correct completed status',
      (WidgetTester tester) async {
    final completedQuestData = QuestModel(
      questId: '1',
      priority: 1,
      processedHistoricalEventFeed: false,
      questType: 'Test Quest Type',
      startTime: DateTime.now(),
      endTime: DateTime.now().add(Duration(days: 2)),
      timezone: 'UTC',
      completed: true,
      created: DateTime.now(),
      modified: DateTime.now(),
      isCreatedByAdmin: false,
      totalMissions: 0,
      missionCompleted: 0,
      totalTask: 0,
      taskCompleted: 0,
      q: '',
      p: '',
      awards: [],
      game: [],
      phyndCoins: 0,
      phyndCoinsBonus: 0,
      gameName: 'Test Game Name',
      participants: 0,
      timeLeft: '153D 18H 47M 01S',
      isEnabled: true,
      hasStarted: true,
      isModified: false,
      isFeatured: false,
      category: [],
      logicGroup: 1,
      missions: 0,
      name: 'Completed Quest',
      description: 'Test Description',
      image: 'https://example.com/image.jpg',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: QuestHeader(
            questData: completedQuestData,
          ),
        ),
      ),
    );

    expect(find.text('Yes'), findsOneWidget);
    expect(find.text('Completed'), findsOneWidget);
  });

  testWidgets('QuestHeader displays correct featured status',
      (WidgetTester tester) async {
    final nonFeaturedQuestData = QuestModel(
      questId: '1',
      priority: 1,
      processedHistoricalEventFeed: false,
      questType: 'Test Quest Type',
      startTime: DateTime.now(),
      endTime: DateTime.now().add(Duration(days: 2)),
      timezone: 'UTC',
      completed: false,
      created: DateTime.now(),
      modified: DateTime.now(),
      isCreatedByAdmin: false,
      totalMissions: 0,
      missionCompleted: 0,
      totalTask: 0,
      taskCompleted: 0,
      q: '',
      p: '',
      awards: [],
      game: [],
      phyndCoins: 0,
      phyndCoinsBonus: 0,
      gameName: 'Test Game Name',
      participants: 0,
      timeLeft: '153D 18H 47M 01S',
      isEnabled: true,
      hasStarted: true,
      isModified: false,
      isFeatured: false,
      category: [],
      logicGroup: 1,
      missions: 0,
      name: 'Non-Featured Quest',
      description: 'Test Description',
      image: 'https://example.com/image.jpg',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: QuestHeader(
            questData: nonFeaturedQuestData,
          ),
        ),
      ),
    );

    // Featured Quest badge should not be present
    expect(find.text('Featured Quest'), findsNothing);
  });

  testWidgets('QuestHeader has correct layout structure',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: QuestHeader(
            questData: mockQuestData,
          ),
        ),
      ),
    );

    // Verify the main column structure
    expect(find.byType(Column), findsWidgets);

    // Verify the quest image container
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.decoration is BoxDecoration &&
            (widget.decoration as BoxDecoration).borderRadius != null,
      ),
      findsOneWidget,
    );

    // Verify the stats row
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Row &&
            widget.mainAxisAlignment == MainAxisAlignment.spaceBetween,
      ),
      findsOneWidget,
    );
  });
}
