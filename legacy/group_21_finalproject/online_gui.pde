class online_gui{
  int x, y;
  int w, h;
  Textfield search_artist;
  
  online_gui(int _x, int _y, int _w, int _h){
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
    text("Lyric Search",30,70);
    float temp_width = textWidth("Lyric Search");
    textSize(15);
    text("API engine courtesy of ChartLyrics and iTunes",40 + temp_width,70);
    
    search_artist = cp5.addTextfield("Enter Artist Name")
     .setPosition(50,90)
     .setSize(325, 20)
     .setFocus(true)
     .setAutoClear(false)
     //.setFont(createFont("arial",12,true))
     .setColor(color(255,255,255))
     ;
     search_artist.getCaptionLabel().setColor(color(10,20,30,140));
  }
  
  void show_results(){
    results.show();
    text("Click the top row to change songs",50,150);
  }
  
  void hide(){
    search_artist.hide();
    results.hide();
    lyrics.hide();
    timer.hide();
    buttonToYoutube.hide();
  } 
}