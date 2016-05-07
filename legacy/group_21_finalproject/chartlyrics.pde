class ChartLyrics {
  String artistName;
  String song;
  String lyric;
  
  ChartLyrics(String _artistName,String _song){
    artistName = _artistName;
    song = _song;
    lyric = "";
  }
  
  void display(){
    background(200);
    textSize(30);
    text("Lyric Search",30,70);
    float temp_width = textWidth("Lyric Search");
    textSize(15);
    text("API engine courtesy of ChartLyrics and iTunes",40 + temp_width,70);
    text("Click the top row to change songs",50,150);
    text(song +" by "+ artistName, 425, 150);
  }
  
  String getLyrics(){
    String artistName = this.artistName.trim().replaceAll(" ", "%20");
    String song = this.song.trim().replaceAll(" ", "%20");
    String baseURL = "http://api.chartlyrics.com/apiv1.asmx/SearchLyricDirect?";
    String lyricsURL = baseURL + "artist="+artistName+"&song="+song; 
    println (lyricsURL);
  
    XML checkinData = loadXML (lyricsURL);
    XML[] lyrics = checkinData.getChildren("Lyric");
    String lyric = lyrics[0].getContent();
    if (lyric.equals("")){
      println ("Lyric not found");
    } else {
      println ("lyric found");
    }
    println (lyric);
    return (lyric);
  }
}