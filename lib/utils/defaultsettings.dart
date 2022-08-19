Map<String, Map<String, dynamic>> getDefaultSettings() {
  Map<String, Map<String, dynamic>> SETTINGS = {
    "unit": {
      "type": "String",
      "default": "WPM",
      "options": ["WPM", "CPM"],
    },
    "theme": {
      "type": "String",
      "default": "light",
      "options": ["light", "dark", "megumin"],
    },
    "time": {
      "type": "int",
      "default": 15,
      "options": [5, 10, 15, 30, 45, 60],
    },
    "wakelock": {
      "type": "int",
      "default": 0,
      "options": [0, 1],
      "options_titles": ["Off", "On"],
    }
  };
  return SETTINGS;
}
