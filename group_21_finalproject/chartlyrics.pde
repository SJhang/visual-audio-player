class chartlyrics {
  String artist_name;
  String song_name;
  
  chartlyrics(String _song_name,String _artist_name){
    artist_name = _artist_name;
    song_name = _song_name;
  }
  
  void getLyrics(){
    background(200);
    textSize(30);
    text("Lyric Search",30,70);
    float temp_width = textWidth("Lyric Search");
    textSize(15);
    text("API engine courtesy of ChartLyrics and iTunes",40 + temp_width,70);
    text("Click the top row to change songs",50,150);
    text(song_name +"by"+ artist_name,425,150);
    artist_name = artist_name.replaceAll(" ","+");  
    song_name = song_name.replaceAll(" ","+");
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
      String lyricURL = "http://api.chartlyrics.com/apiv1.asmx/GetLyric?lyricId="+lyric_id.get(0)+"&lyricCheckSum="+checksum.get(0);
      XML lyric = loadXML(lyricURL);
      String song_lyric = lyric.getChild("Lyric").getContent();
      lyrics.setText(song_lyric);
   
    }
    else{
      print("error");
    }
    
  }
  
}