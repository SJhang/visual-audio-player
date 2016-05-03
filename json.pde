import processing.data.JSONObject;

void setup(){
  getSongs("Lukas Graham");
  getLyrics("Miachel Jackson", "billie Jean");
}

ArrayList<String> getSongs (String name){
  String artist = name.replaceAll(" ", "+");
  //println (name);
  //println (artist);
  String baseURL = "https://itunes.apple.com/search?term=";
  String artistIdURL = baseURL + artist + "&entity=album";
  println (artistIdURL);
  
  processing.data.JSONObject checkinData = loadJSONObject(artistIdURL);
  processing.data.JSONArray result = checkinData.getJSONArray("results");
  processing.data.JSONObject singleArtist = result.getJSONObject(0);
  int artistID = singleArtist.getInt ("artistId");
  String artistName = singleArtist.getString ("artistName");
  //println (artistID);
  
  String lookupURL = "https://itunes.apple.com/lookup?id=";
  String artistURL = lookupURL + artistID +"&entity=song&limit=200";
  println (artistURL);
  
  processing.data.JSONObject artistInfo = loadJSONObject (artistURL);
  processing.data.JSONArray results = artistInfo.getJSONArray("results");
  
  ArrayList<String> songList = new ArrayList<String>();
  songList.add (artistName);
  
  for (int i=1; i <results.size(); i++){
    processing.data.JSONObject singleSong = results.getJSONObject(i);
    //println (i);
    String trackName = singleSong.getString ("trackName");
    songList.add (trackName);
  }
  println (songList);
  return (songList);
  //println ("done");
}

String getLyrics(String artists, String songs){
  String artist = artists.replaceAll(" ", "%20");
  String song = songs.replaceAll(" ", "%20");
  
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
}