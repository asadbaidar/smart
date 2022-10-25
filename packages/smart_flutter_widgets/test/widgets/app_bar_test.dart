import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_flutter_utils/smart_flutter_utils.dart';
import 'package:smart_flutter_widgets/smart_flutter_widgets.dart';

const _mockSliverText = "mock-sliver-text";

extension on WidgetTester {
  Future<void> pumpSmartAppBarSliver(List<Widget> slivers) async {
    return pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomScrollView(
            physics: const AlwaysBouncingScrollPhysics(),
            slivers: [
              ...slivers,
              const Text(_mockSliverText).sliverFill,
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  const mockTitleText = "title-text";
  const mockWidget = SizedBox(
    key: Key("mock-widget"),
  );

  const Key titleSmallWithoutLarge = Key("title-small-without-large");
  const Key titleSmallWithLarge = Key("title-small-with-large");
  const Key titleLarge = Key('title-large');
  const Key backButton = Key("back-button");
  const Key bottomFixed = Key("bottom-fixed");
  const Key bottomAnimated = Key("bottom-animated");

  late MockFutureCallBack mockOnRefesh;

  setUp(() {
    mockOnRefesh = MockFutureCallBack();
  });

  group('SmartAppBar.sliver', () {
    group('renders', () {
      testWidgets('nothing without parameters', (tester) async {
        await tester.pumpSmartAppBarSliver(SmartAppBar.sliver());

        expect(find.byType(SliverAppBar), findsNothing);
        expect(find.byType(SmartCupertinoSliverRefresh), findsNothing);
        expect(find.byType(SliverLayoutBuilder), findsNothing);
      });

      testWidgets('with title provided and default parameters', (tester) async {
        await tester.pumpSmartAppBarSliver(SmartAppBar.sliver(
          title: mockTitleText,
        ));

        SliverAppBar appBar =
            tester.widget<SliverAppBar>(find.byType(SliverAppBar));

        expect(find.byType(SliverLayoutBuilder), findsNWidgets(2));
        expect(find.text(mockTitleText), findsNWidgets(2));
        expect(find.byKey(titleSmallWithoutLarge), findsNothing);
        expect(find.byKey(titleSmallWithLarge), findsOneWidget);
        expect(find.byKey(titleLarge), findsOneWidget);
        expect(find.byKey(backButton), findsNothing);
        expect(find.byKey(bottomFixed), findsNothing);
        expect(find.byKey(bottomAnimated), findsOneWidget);
        expect(appBar.actions, null);
        expect(appBar.pinned, true);
        expect(appBar.floating, false);
      });

      testWidgets(
          'refresh control and calls onRefresh '
          'callback when fling gesture perfomed', (tester) async {
        await tester.pumpSmartAppBarSliver(SmartAppBar.sliver(
          title: mockTitleText,
          onRefresh: mockOnRefesh,
        ));
        await tester.fling(
          find.text(_mockSliverText),
          const Offset(0.0, 300.0),
          1000.0,
        );
        await tester.pump();

        expect(find.byType(SmartCupertinoSliverRefresh), findsOneWidget);
        expect(mockOnRefesh.called(1), true);
        expect(find.byType(SliverLayoutBuilder), findsNWidgets(2));
        expect(find.text(mockTitleText), findsNWidgets(2));
      });

      testWidgets('only small title if largeTitle is false', (tester) async {
        await tester.pumpSmartAppBarSliver(SmartAppBar.sliver(
          title: mockTitleText,
          largeTitle: false,
        ));

        expect(find.byType(SliverLayoutBuilder), findsNWidgets(2));
        expect(find.text(mockTitleText), findsOneWidget);
        expect(find.byKey(titleSmallWithoutLarge), findsOneWidget);
        expect(find.byKey(titleSmallWithLarge), findsNothing);
        expect(find.byKey(titleLarge), findsNothing);
      });

      testWidgets('only large title if smallTitle is false', (tester) async {
        await tester.pumpSmartAppBarSliver(SmartAppBar.sliver(
          title: mockTitleText,
          smallTitle: false,
        ));

        expect(find.byType(SliverLayoutBuilder), findsNWidgets(2));
        expect(find.text(mockTitleText), findsOneWidget);
        expect(find.byKey(titleSmallWithoutLarge), findsNothing);
        expect(find.byKey(titleSmallWithLarge), findsNothing);
        expect(find.byKey(titleLarge), findsOneWidget);
      });

      testWidgets('backButton if showLeading is true', (tester) async {
        await tester.pumpSmartAppBarSliver(SmartAppBar.sliver(
          showLeading: true,
        ));

        expect(find.byType(SliverLayoutBuilder), findsNWidgets(2));
        expect(find.byKey(backButton), findsOneWidget);
      });

      testWidgets('action widgets if provided', (tester) async {
        await tester.pumpSmartAppBarSliver(SmartAppBar.sliver(
          actions: [mockWidget],
        ));

        expect(find.byType(SliverLayoutBuilder), findsNWidgets(2));
        expect(find.byWidget(mockWidget), findsOneWidget);
      });

      testWidgets('large action widgets if provided', (tester) async {
        await tester.pumpSmartAppBarSliver(SmartAppBar.sliver(
          largeActions: [mockWidget],
        ));

        expect(find.byType(SliverLayoutBuilder), findsNWidgets(2));
        expect(find.byWidget(mockWidget), findsOneWidget);
      });

      testWidgets('progress bar if showProgress is true', (tester) async {
        await tester.pumpSmartAppBarSliver(SmartAppBar.sliver(
          showProgress: true,
        ));

        expect(find.byType(SliverLayoutBuilder), findsNWidgets(2));
        expect(find.byType(SmartLinearProgress), findsOneWidget);
      });

      testWidgets('bottom widget if provided', (tester) async {
        await tester.pumpSmartAppBarSliver(SmartAppBar.sliver(
          bottom: mockWidget,
        ));

        expect(find.byType(SliverLayoutBuilder), findsNWidgets(2));
        expect(find.byWidget(mockWidget), findsOneWidget);
      });

      testWidgets('below bottom widgets if provided', (tester) async {
        await tester.pumpSmartAppBarSliver(SmartAppBar.sliver(
          belowBottom: [mockWidget],
        ));

        expect(find.byType(SliverLayoutBuilder), findsNWidgets(2));
        expect(find.byWidget(mockWidget), findsOneWidget);
      });

      testWidgets('custom title widget if provided', (tester) async {
        await tester.pumpSmartAppBarSliver(SmartAppBar.sliver(
          customTitle: mockWidget,
        ));

        expect(find.byType(SliverLayoutBuilder), findsNWidgets(2));
        expect(find.byWidget(mockWidget), findsOneWidget);
      });

      testWidgets('custom large title widget if provided', (tester) async {
        await tester.pumpSmartAppBarSliver(SmartAppBar.sliver(
          customLargeTitle: mockWidget,
        ));

        expect(find.byType(SliverLayoutBuilder), findsNWidgets(2));
        expect(find.byWidget(mockWidget), findsOneWidget);
      });

      testWidgets('custom leading if provided and showLeading is true',
          (tester) async {
        await tester.pumpSmartAppBarSliver(SmartAppBar.sliver(
          leading: mockWidget,
          showLeading: true,
        ));

        expect(find.byType(SliverLayoutBuilder), findsNWidgets(2));
        expect(find.byWidget(mockWidget), findsOneWidget);
      });

      testWidgets('flexible space widget if provided', (tester) async {
        await tester.pumpSmartAppBarSliver(SmartAppBar.sliver(
          flexibleSpace: mockWidget,
        ));

        expect(find.byType(SliverLayoutBuilder), findsNWidgets(2));
        expect(find.byWidget(mockWidget), findsOneWidget);
      });

      testWidgets('no actions except backButton if interactive is false',
          (tester) async {
        await tester.pumpSmartAppBarSliver(SmartAppBar.sliver(
          interactive: false,
          actions: [mockWidget],
          largeActions: [mockWidget],
          showLeading: true,
        ));

        expect(find.byType(SliverLayoutBuilder), findsNWidgets(2));
        expect(find.byWidget(mockWidget), findsNothing);
        expect(find.byKey(backButton), findsOneWidget);
      });

      testWidgets('custom progress bar if provided', (tester) async {
        await tester.pumpSmartAppBarSliver(SmartAppBar.sliver(
          progress: const SmartLinearProgress(),
        ));

        expect(find.byType(SliverLayoutBuilder), findsNWidgets(2));
        expect(find.byType(SmartLinearProgress), findsOneWidget);
      });

      testWidgets(
          'as floating and pinned bar if floating is '
          'true and pinned is default', (tester) async {
        await tester.pumpSmartAppBarSliver(SmartAppBar.sliver(
          title: mockTitleText,
          floating: true,
        ));

        SliverAppBar appBar =
            tester.widget<SliverAppBar>(find.byType(SliverAppBar));

        expect(find.byType(SliverLayoutBuilder), findsNWidgets(2));
        expect(find.text(mockTitleText), findsNWidgets(2));
        expect(appBar.floating, true);
        expect(appBar.pinned, true);
      });

      testWidgets('as floating bar if pinned and floating both are false',
          (tester) async {
        await tester.pumpSmartAppBarSliver(SmartAppBar.sliver(
          title: mockTitleText,
          floating: false,
          pinned: false,
        ));

        SliverAppBar appBar =
            tester.widget<SliverAppBar>(find.byType(SliverAppBar));

        expect(find.byType(SliverLayoutBuilder), findsNWidgets(2));
        expect(find.text(mockTitleText), findsNWidgets(2));
        expect(appBar.floating, true);
        expect(appBar.pinned, false);
      });

      testWidgets(
          'as floating and pinned bar if floating '
          'and pinned both are true', (tester) async {
        await tester.pumpSmartAppBarSliver(SmartAppBar.sliver(
          title: mockTitleText,
          floating: true,
          pinned: true,
        ));

        SliverAppBar appBar =
            tester.widget<SliverAppBar>(find.byType(SliverAppBar));

        expect(find.byType(SliverLayoutBuilder), findsNWidgets(2));
        expect(find.text(mockTitleText), findsNWidgets(2));
        expect(appBar.floating, true);
        expect(appBar.pinned, true);
      });
    });
  });
}
