class local_gui{
  int x, y;
  int w, h;
  
  local_gui(int _x, int _y, int _w, int _h){
    x = _x;
    y = _y;
    w = _w;
    h = _h;
  }
  
  void display(){
    background(200);
    fill(55);
    textAlign(LEFT);
    textSize(30);
    text("Play Local Track",30,70);
  }
  void hide(){
  }
}