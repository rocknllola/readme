class Vtx { 
  float x, y, p; 
  int t;
}  
class Shp {
  ArrayList<Vtx> vertexes = new ArrayList<Vtx>();
  boolean visible = false;
  void paint(){
    if (visible){
      stroke(255);
    for(int i=0;i<vertexes.size()-1;i++){
      Vtx v0 = vertexes.get(i);
      Vtx v1 = vertexes.get(i+1);
      strokeWeight(v0.p*10);
      line(v0.x, v0.y, v1.x, v1.y);
    }
    }
    
  }
  void show(){
    visible = true;
  }
  void hide(){
    visible = false;
  }
}
ArrayList<Shp> shapes = new ArrayList<Shp>();

JSONArray ps;
JSONObject p;

void setup() {
  fullScreen();
  background(0);
  selectFolder("Select a data folder to process:", "folderSelected");
  
}

void folderSelected(File selection) {
  if (selection != null) {
File[] files = listFiles(selection);
  for (int k = 0; k < files.length; k++) {
    File f = files[k];    
    String fn = f.getName();
    if (fn.endsWith(".json")){
      ps = loadJSONArray(f.getAbsolutePath());
  Shp sh = null;
  for (int i=0;i<ps.size();i++){
      p = ps.getJSONObject(i);
      
      Vtx v = new Vtx();
      v.x = p.getFloat("x");
      v.y = p.getFloat("y");
      v.p = p.getFloat("pressure");
      v.t = p.getInt("t");
      if (p.getBoolean("start")){
        if (sh != null) shapes.add(sh);
        sh = new Shp();
      }
      if (sh != null) sh.vertexes.add(v);
  }
  if (sh != null) shapes.add(sh);
  }
    }
  }

    
}

void draw() {
  if (shapes.size()>0){
    stroke(255);
  Shp sh1 = shapes.get(round(random(0, shapes.size()-1)));
  sh1.show();
  Shp sh2 = shapes.get(round(random(0, shapes.size()-1)));
  sh2.hide();
  clear();
  for (int i=0; i<shapes.size();i++){
    Shp sh = shapes.get(i);
    sh.paint();
  }
  }
  

}
