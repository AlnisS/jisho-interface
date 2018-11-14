class Word {
  boolean is_common;
  String[] tags;
  Japanese[] japanese;
  Sense[] senses;
  Word(JSONObject json) {
    this.is_common = json.getBoolean("is_common");
    this.tags = json.getJSONArray("tags").getStringArray();
    
    JSONArray japanese_array = json.getJSONArray("japanese");
    japanese = new Japanese[japanese_array.size()];
    for (int i = 0; i < japanese_array.size(); i++) {
      japanese[i] = new Japanese(japanese_array.getJSONObject(i));
    }
    
    JSONArray senses_array = json.getJSONArray("senses");
    senses = new Sense[senses_array.size()];
    for (int i = 0; i < senses_array.size(); i++) {
      senses[i] = new Sense(senses_array.getJSONObject(i));
    }
  }
}

Word[] loadFromJSONArray(JSONArray array) {
  Word[] result = new Word[array.size()];
  for (int i = 0; i < array.size(); i++) {
    result[i] = new Word(array.getJSONObject(i));
  }
  return result;
}
