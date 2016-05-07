class ITunes{
  String artistName;
  ArrayList<String> songResults;
  
  ITunes(String _artistName){
    artistName = _artistName.trim().replaceAll(" ", "+");
    songResults = new ArrayList<String>();
  }
  
  ArrayList<String> getSongs (){
    String artist = artistName.replaceAll(" ", "+");
    String baseURL = "https://itunes.apple.com/search?term=";
    String artistIdURL = baseURL + artist + "&entity=album";
    println (artistIdURL);
  
    processing.data.JSONObject checkinData = loadJSONObject(artistIdURL);
    processing.data.JSONArray result = checkinData.getJSONArray("results");
    processing.data.JSONObject singleArtist = result.getJSONObject(0);
    int artistID = singleArtist.getInt ("artistId");
    String singleArtistName = singleArtist.getString ("artistName");
    println (artistID);
  
    String lookupURL = "https://itunes.apple.com/lookup?id=";
    String artistURL = lookupURL + artistID +"&entity=song&limit=200";
    println (artistURL);
  
    processing.data.JSONObject artistInfo = loadJSONObject (artistURL);
    processing.data.JSONArray results = artistInfo.getJSONArray("results");
  
    ArrayList<String> songResults = new ArrayList<String>();
    songResults.add (singleArtistName);
  
    for (int i=1; i <results.size(); i++){
      processing.data.JSONObject singleSong = results.getJSONObject(i);
      //println (i);
      String trackName = singleSong.getString ("trackName");
      songResults.add (trackName);
    }
    println (songResults);
    return (songResults);
  }
}