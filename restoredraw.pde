JSONArray values;
int t = 0;
JSONObject p0, p1;
int m = 0;
int i = 0;

void setup() {
  size(800, 600);
  background(0);
  values = loadJSONArray("../data/new.json");
  m = values.size();
}

void draw() {
  stroke(255);
  if (i<m) {
    p0 = values.getJSONObject(i);

    if (p0.getInt("t") <= millis()) {
      i++;
      if (i<m) {
        p1 = values.getJSONObject(i);
        strokeWeight(p1.getFloat("pressure")*50);

        line(p0.getFloat("x"), p0.getFloat("y"), p1.getFloat("x"), p1.getFloat("y"));
      }
    }
  }
}
