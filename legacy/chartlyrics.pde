class chartlyrics {
  String artist;
  String song;
  
  chartlyrics(String _song_name,String _artist_name){
    artist = _artist_name;
    song = _song_name;
  }

  String getLyrics(String songs, String artists){
    artist = artists.replaceAll(" ", "%20");
    song = songs.replaceAll(" ", "%20");
    background(200);
    textSize(30);
    text("Search For Lyrics",30,70);
    float temp_width = textWidth("Search For Lyrics");
    textSize(15);
    text("API engine courtesy of ChartLyrics and iTunes",40 + temp_width,70);
    text("Click the top row to change songs",50,150);
    text(song +"by"+ artist, 425, 150);
    //artist_name = artist_name.replaceAll("\\W","");
    //song_name = song_name.replaceAll(" ","%20");
    //String baseURL = "http://api.chartlyrics.com/apiv1.asmx/SearchLyric?artist="+ artist_name +"&song="+ song_name;
    //String baseURL = "http://api.chartlyrics.com/apiv1.asmx/SearchLyric?artist=Eminem&song=Lose%20Yourself";
    String baseURL = "http://api.chartlyrics.com/apiv1.asmx/SearchLyricDirect?";
    String lyricsURL = baseURL + "artist="+artist+"&song="+song; 
    println (lyricsURL);

    XML checkinData = loadXML (lyricsURL);
    XML[] lyrics = checkinData.getChildren("Lyric");
    String lyric = lyrics[0].getContent();
    
    if (lyric.equals("")){
      println ("Lyric not found");
    } else {
      println ("lyric found");
    }
    return (lyric);
    /*
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
      String lyricURL = "http://api.chartlyrics.com/apiv1.asmx/GetLyric?lyricId="+lyric_id.get(0)+"&lyricCheckSum="+checksum.get(0);
      XML lyric = loadXML(lyricURL);
      String song_lyric = lyric.getChild("Lyric").getContent();
      lyrics.setText(song_lyric);
   
    }
    else{
      print("error");
    }
    return "";
    */
  }
  void showLyric(){
    getLyrics (song, artist); 
  }
  
}