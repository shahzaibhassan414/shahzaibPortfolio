import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/resource/strings.dart';
import 'package:portfolio/view/root.dart';
import 'package:portfolio/view/widget/footer.dart';

void main() {
  testWidgets('portfolio renders its primary content', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1440, 1400));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      const ProviderScope(
        child: AppTheme(),
      ),
    );
    await tester.pump();

    expect(find.byType(RootScreen), findsOneWidget);
    expect(find.text(Strings.introHeadline), findsOneWidget);
    expect(find.byType(Footer), findsOneWidget);
  });
}
