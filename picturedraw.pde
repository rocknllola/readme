import codeanticode.tablet.*;
class APoint {
  float x, y, p;
  int t;
  boolean start = false;
  APoint (float px, float py, float pressure, int pt, boolean s) {  
    x = px;
    y = py;
    t = pt;
    p = pressure;
    start = s;
  }
  void print() {
    println(x, y, p, t, start);
  }
}
boolean status = false;
ArrayList<APoint> points = new ArrayList<APoint>();
APoint p;
Button btn;
int cTime = 0;
Tablet tablet;

void setup() {
  size(640, 360);
  noStroke();
  tablet = new Tablet(this); 
  background(0);
  btn = new Button(0, 0, 100, 20, color(128, 0, 0), color(255, 0, 0), "print");
}

void draw() {
  btn.buttonDisplay();
  stroke(255);
  if (mousePressed == true) {
    strokeWeight(tablet.getPressure()*50);
    line(mouseX, mouseY, pmouseX, pmouseY);
  }
}

void mousePressed() {
  status = true;
  cTime = millis();
}

void mouseReleased() {
  status = false;
} 

void mouseDragged() {
  p = new APoint(mouseX, mouseY,tablet.getPressure(), millis() - cTime, status);
  points.add(p);
  status = false;
}

class Button {

  int buttonX, buttonY, buttonWidth, buttonHeight, bgColor, bgColorOver;
  boolean overButton, buttonOn;
  String label;

  Button(int tempbuttonX, int tempbuttonY, int tempbuttonWidth, int tempbuttonHeight, int bgc, int bgco, String l) {
    buttonX = tempbuttonX;
    buttonY = tempbuttonY;
    buttonWidth = tempbuttonWidth;
    buttonHeight = tempbuttonHeight;
    bgColor = bgc;
    bgColorOver = bgco;
    label = l;
  }

  void buttonDisplay() {
    if (isOver(mouseX, mouseY)) {
      fill(bgColorOver);
    } else {
      fill(bgColor);
    }
    rect(buttonX, buttonY, buttonWidth, buttonHeight);
    fill(255);
    textAlign(CENTER);
    textSize(buttonHeight - 2);
    text(label, buttonX + buttonWidth / 2, buttonY + buttonHeight - 4);
  }

  boolean isOver(int x, int y) {
    return x > buttonX && x < buttonX+buttonWidth && y > buttonY && y < buttonY+buttonHeight;
  }

  boolean hasClicked() {
    boolean changeState = isOver(mouseX, mouseY);
    if (changeState) {
      buttonOn = !buttonOn;
    }
    return changeState;
  }
}

void mouseClicked() {
  if ( btn.hasClicked()) {
    JSONArray values = new JSONArray();

    for (APoint p : points) {
      JSONObject jp = new JSONObject();
      jp.setFloat("x", p.x);
      jp.setFloat("y", p.y);
      jp.setFloat("pressure", p.p);
      jp.setInt("t", p.t);
      jp.setBoolean("start", p.start);
      values.append(jp);
    }

    saveJSONArray(values, "data/new.json");
  }
}
