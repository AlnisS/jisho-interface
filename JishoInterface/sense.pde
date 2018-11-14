class Sense {
  String[] english_definitions;
  String[] parts_of_speech;
  Link[] links;
  String[] tags;
  String[] restrictions;
  String[] see_also;
  String[] antonyms;
  String[] source;
  String[] info;
  Sense(JSONObject json) {
    english_definitions = json.getJSONArray("english_definitions").getStringArray();
    parts_of_speech = json.getJSONArray("parts_of_speech").getStringArray();
    
    JSONArray links_array = json.getJSONArray("links");
    links = new Link[links_array.size()];
    for (int i = 0; i < links_array.size(); i++) {
      links[i] = new Link(links_array.getJSONObject(i));
    }
    
    tags = json.getJSONArray("tags").getStringArray();
    restrictions = json.getJSONArray("restrictions").getStringArray();
    see_also = json.getJSONArray("see_also").getStringArray();
    antonyms = json.getJSONArray("antonyms").getStringArray();
    source = json.getJSONArray("source").getStringArray();
    info = json.getJSONArray("info").getStringArray();
  }
  void addToLeveledPrinter(LeveledPrinter printer) {
    printer.addString("english_definitions: ");
    printer.addAllLeveling(english_definitions);
    
    printer.addString("parts_of_speech: ");
    printer.addAllLeveling(parts_of_speech);
    
    printer.addString("links: ");
    printer.addAllLeveling(links);
  }
}
