import processing.data.JSONObject;
import processing.data.JSONArray;

class Sense {
   public String[] english_definitions;
   public String[] parts_of_speech;
   public Link[] links;
   public String[] tags;
   public String[] restrictions;
   public String[] see_also;
   public String[] antonyms;
   public String[] source;
   public String[] info;
   
   public Sense(JSONObject json) {
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
   
   public static Sense[] loadFromJSONArray(JSONArray senses_array) {
      Sense[] senses = new Sense[senses_array.size()];
      for (int i = 0; i < senses_array.size(); i++) {
         senses[i] = new Sense(senses_array.getJSONObject(i));
      }
      return senses;
   }
}