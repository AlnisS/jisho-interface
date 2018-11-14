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
