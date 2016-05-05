class Itunes{
  String artist_name;
  
  Itunes(String _artist_name){
    artist_name = _artist_name;
  }
  
  ArrayList<String> getSongs(String name){
    String artist = name.replaceAll(" ", "+");
    String baseURL = "https://itunes.apple.com/search?term=";
    String artistIdURL = baseURL + artist + "&entity=album";
    println (artistIdURL);
  
    processing.data.JSONObject checkinData = loadJSONObject(artistIdURL);
    processing.data.JSONArray result = checkinData.getJSONArray("results");
    processing.data.JSONObject singleArtist = result.getJSONObject(0);
    int artistID = singleArtist.getInt ("artistId");
    String artistName = singleArtist.getString ("artistName");
    
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
   return (songList);
 }
 void display(){
   getSongs (artist_name);
}