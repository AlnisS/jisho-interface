import processing.data.JSONObject;
import processing.data.JSONArray;

public class Word {
   public boolean is_common;
   public String[] tags;
   public Japanese[] japanese;
   public Sense[] senses;
   
   public Word(JSONObject json) {
      is_common = json.getBoolean("is_common");
      tags = json.getJSONArray("tags").getStringArray();
      japanese = Japanese.loadFromJSONArray(json.getJSONArray("japanese"));
      senses = Sense.loadFromJSONArray(json.getJSONArray("senses"));
   }
   
   public static Word[] loadFromJSONArray(JSONArray array) {
      Word[] result = new Word[array.size()];
      for (int i = 0; i < array.size(); i++) {
         result[i] = new Word(array.getJSONObject(i));
      }
      return result;
   }
}