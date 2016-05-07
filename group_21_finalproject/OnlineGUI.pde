class OnlineGUI{
  controlP5.ScrollableList results;
  controlP5.Button buttonToYoutube;
  Textarea lyrics;
  Textfield search_artist;
  
  OnlineGUI (ControlP5 cp5){
        //////////////ONLINE GUI//////////////////////

        search_artist = cp5.addTextfield("Enter Artist Name")
                           .setPosition(50,90)
                           .setSize(325, 20)
                           .setFocus(true)
                           .setAutoClear(false)
                           //.setFont(createFont("arial",12,true))
                           .setColor(color(255,255,255))
                           .hide()
                           ;
        search_artist.getCaptionLabel().setColor(color(10,20,30,140));
        search_artist.setColor(255);
         
        results = cp5.addScrollableList("results")
                     .setPosition(50, 155)
                     .setSize(325, 300)
                     .setBarHeight(20)
                     .setItemHeight(20)
                     .setOpen(false)
                     .plugTo(this, "results")
                     .hide()
                     ;
        
        lyrics = cp5.addTextarea("lyrics")
                    .setPosition(425,155)
                    .setSize(325,500)
                    .setFont(createFont("arial",12))
                    .setLineHeight(14)
                    .setColor(color(128))
                    .setColorBackground(color(255,100))
                    .setColorForeground(color(255,100))
                    .hide()
                    ;
                    
        buttonToYoutube = cp5.addButton("Youtube")
                             .setBroadcast(false)
                             .setValue(50)
                             .setPosition(50,500)
                             .activateBy(ControlP5.RELEASE)
                             .setSize(150,40)
                             .plugTo (this, "Youtube")
                             .setBroadcast(true)
                             .hide()
                             ;
  }
  

  void results(int n) {
    lyrics.show();
    /* request the selected item based on index n */
    println(n, cp5.get(ScrollableList.class, "results").getItem(n));
    Map info = cp5.get(ScrollableList.class, "results").getItem(n);
    String song_artist = (String)info.get("name");
    String[] temp = song_artist.split(":");
    
    lyricsResult = new ChartLyrics(temp[0].trim(),temp[1].trim());
    String lyricsText = lyricsResult.getLyrics();
    lyricsResult.display();
    
    if (lyricsText == ""){
      lyrics.clear();
      lyrics.append ("Lyrics not found :(");
    } else{
      lyrics.clear();
      lyrics.append (lyricsText);
    }
    
    youtubeResult = new Youtube (temp[0], temp[1]);
    youtubeLink = youtubeResult.getYoutubeLink();
    buttonToYoutube.show();
    
    CColor c = new CColor();
    c.setBackground(color(255,0,0));
    cp5.get(ScrollableList.class, "results").getItem(n).put("color", c);
    
}
  void Youtube (int n){
    link (youtubeLink); 
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
  }

  public void show(){
    search_artist.show();
  }
  
  public void hide(){
    search_artist.hide();
    results.hide();
    lyrics.hide();
    buttonToYoutube.hide();
  } 
}