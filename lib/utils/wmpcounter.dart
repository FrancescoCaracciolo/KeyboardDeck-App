import 'dart:convert';

class WPMCounter {
  Map<int, String> words = {};
  int deleteAfter = 3600;

  WPMCounter(this.deleteAfter);

  void add(String letter) {
    int second = (DateTime.now().millisecondsSinceEpoch / 1000).round() as int;
    if (words.containsKey(second)) {
      words[second] = words[second]! + letter;
    } else {
      words[second] = letter;
    }
    deleteOld(deleteAfter);
  }

  void addFromJson(String response) {
    Map r = json.decode(response) as Map;
    r["keys"].forEach((key, value) {
      add(value);
    });
  }

  int calculateWPM(int seconds) {
    int max = (DateTime.now().millisecondsSinceEpoch / 1000).round() as int;
    max -= seconds as int;
    int letters = 0;
    String string = "";
    Map.from(words).forEach((key, value) {
      if (key >= max) {
        if (words[key]?.length != null) {
          letters += words[key]?.length as int;
          string += words[key] as String;
        }
      }
    });
    return ((letters / 5) * 60 / seconds).round();
  }

  void deleteOld(int limit) async {
    int max = (DateTime.now().millisecondsSinceEpoch / 1000).round() as int;
    max -= limit as int;
    Map.from(words).forEach((key, value) {
      if (key < max) {
        words.remove(key);
      }
    });
  }
}
