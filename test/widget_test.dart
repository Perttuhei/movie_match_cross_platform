// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moviematch/widgets/big_card.dart';

void main() {
  testWidgets('big_card has wordpair', (WidgetTester tester) async {

    final pari = WordPair("first", "second");
    // testataan muodostaako bigCard sanaparin, rakennetaan widgetti
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: BigCard(pair: pari),),));

    // odotetaan widgetillä olevan sana firstsecond joten etsitään sitä
    expect(find.text("firstsecond"), findsOneWidget);

  });
}
