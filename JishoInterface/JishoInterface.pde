Word[] words;

void setup() {
  noLoop();
}

void draw() {
  println("loading...\n");
  JSONObject page = loadJSONObject("https://jisho.org/api/v1/search/words?keyword=door");
  words = loadFromJSONArray(page.getJSONArray("data"));
  
  LeveledPrinter printer = new LeveledPrinter();
  printer.addString("word 0:");
  words[0].addToLeveledPrinter(printer);
  printer.printAll();
}

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
  void addToLeveledPrinter(LeveledPrinter printer) {
    printer.levelIn();
    printer.addString("is_common: " + is_common);
    
    printer.addString("tags:");
    printer.levelIn();
    for (String s : tags)
      printer.addString(s);
    printer.levelOut();
    
    printer.addString("japanese:");
    printer.levelIn();
    for (Japanese j : japanese)
      j.addToLeveledPrinter(printer);
    printer.levelOut();
    
    printer.addString("senses:");
    printer.levelIn();
    int i = 0;
    for (Sense s : senses) {
      printer.addString("sense " + i++ + ":");
      printer.levelIn();
      s.addToLeveledPrinter(printer);
      printer.levelOut();
    }
    printer.levelOut();
    printer.levelOut();
  }
}

Word[] loadFromJSONArray(JSONArray array) {
  Word[] result = new Word[array.size()];
  for (int i = 0; i < array.size(); i++) {
    result[i] = new Word(array.getJSONObject(i));
  }
  return result;
}

class Japanese {
  String word;
  String reading;
  Japanese(JSONObject json) {
    this.word = json.getString("word");
    this.reading = json.getString("reading");
  }
  String toString() {
    return word + ": " + reading;
  }
  void addToLeveledPrinter(LeveledPrinter printer) {
    printer.addString(word + ": " + reading);
  }
}

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
    printer.levelIn();
    for (String s : english_definitions)
      printer.addString(s);
    printer.levelOut();
    
    printer.addString("parts_of_speech: ");
    printer.levelIn();
    for (String s : parts_of_speech)
      printer.addString(s);
    printer.levelOut();
    
    printer.addString("links: ");
    printer.levelIn();
    for (Link l : links)
      printer.addString(l.toString());
    printer.levelOut();
  }
}

class Link {
  String text;
  String url;
  Link(JSONObject json) {
    text = json.getString("text");
    url = json.getString("url");
  }
  String toString() {
    return text + ": " + url;
  }
}

class LeveledPrinter {
  ArrayList<String> strings;
  ArrayList<Integer> levels;
  int curlevel;
  LeveledPrinter() {
    strings = new ArrayList<String>();
    levels = new ArrayList<Integer>();
    curlevel = 0;
  }
  void levelIn() {
    curlevel++;
  }
  void levelOut() {
    curlevel--;
  }
  void addString(String s) {
    strings.add(s);
    levels.add(curlevel);
  }
  void printAll() {
    for (int i = 0; i < strings.size(); i++) {
      String padding = "";
      for (int j = 0; j < levels.get(i); j++) {
        padding += "|   ";
      }
      println(padding + strings.get(i));
    }
  }
}
