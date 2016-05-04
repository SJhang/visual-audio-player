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
    text(song +"by"+ artistName, 425, 150);
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
/*

    String baseURL = "http://api.chartlyrics.com/apiv1.asmx/SearchLyric?artist="+ artist_name +"&song="+ song_name;
    //String baseURL = "http://api.chartlyrics.com/apiv1.asmx/SearchLyric?artist=Eminem&song=Lose%20Yourself";
    println(baseURL);
    lyric_results = loadXML(baseURL);
    println(lyric_results);
    ;
    ArrayList<String> checksum = new ArrayList<String>();
    ArrayList<String> lyric_id = new ArrayList<String>();
    lyrics.setText("Empty Lyrics ):");
    XML[] search_lyric_results = lyric_results.getChildren("SearchLyricResult");
    int counter = 0;
    for(XML x : search_lyric_results){
       counter+=1;
    }
    println(counter);
    if(counter!=1){
      for(int i = 0; i<1;i++){
        checksum.add(search_lyric_results[i].getChild("LyricChecksum").getContent());
        lyric_id.add(search_lyric_results[i].getChild("LyricId").getContent());
      }
    println("lyric_id : " + lyric_id.get(0));
    if(lyric_id.get(0) != "0"){
      String lyricURL = "http://api.chartlyrics.com/apiv1.asmx/GetLyric?lyricId="+lyric_id.get(0)+"&lyricCheckSum="+checksum.get(0);
      println(lyricURL);
      XML lyric = loadXML(lyricURL);
      String song_lyric = lyric.getChild("Lyric").getContent();
      lyrics.setText(song_lyric);
    }
    else{
      println("error");
    }
    }
   
    */