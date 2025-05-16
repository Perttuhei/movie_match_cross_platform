
import 'package:flutter_test/flutter_test.dart';
import 'package:moviematch/providers/moviematch.dart';
import 'package:moviematch/providers/my_app_state.dart';

void main() {
  test("testataan getNext funktiota", () {
    // tallennetaan state ja sen hetkinen current arvo
    final state = MyAppState();
    final text = state.current;
    // kokeillaan vaihtuuko arvo funktiota kutsumalla
    state.getNext();
    // odotetaan että uusi teksti ei ole sama kuin vanha
    expect(state.current, isNot(equals(text)));
  });
}