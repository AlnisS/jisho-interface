import processing.data.JSONObject;
import processing.data.JSONArray;

public class Japanese {
   public String word;
   public String reading;
   public Japanese(JSONObject json) {
      this.word = json.getString("word");
      this.reading = json.getString("reading");
   }
   public String toString() {
      return word + ": " + reading;
   }
   public static Japanese[] loadFromJSONArray(JSONArray japanese_array) {
      Japanese[] japanese = new Japanese[japanese_array.size()];
      for (int i = 0; i < japanese_array.size(); i++) {
         japanese[i] = new Japanese(japanese_array.getJSONObject(i));
      }
      return japanese;
   }
}