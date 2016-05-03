class itunes{
  String artist_name;
  ArrayList<ArrayList<String>> ret = new ArrayList<ArrayList<String>>();
  itunes(String _artist_name){
    artist_name = _artist_name;
  }
  
  ArrayList<ArrayList<String>> getSongs(){
  
  artist_name = artist_name.trim();
  artist_name = artist_name.replaceAll(" ","+");
  String baseURL = "https://itunes.apple.com/search?term=" + artist_name + "&media=music&entity=musicTrack";
  //String url = baseURL + artist +"&entity=album";
  System.out.println (baseURL);
  
  //try {
    //InputStream is = createInput(baseURL); 
    //JsonReader rdr = Json.createReader(is);
    //JSONObject obj = rdr.readObject();
    //processing.data.JSONObject allcheckinData = new processing.data.JSONObject(is);
    processing.data.JSONObject checkinData = loadJSONObject(baseURL);
    processing.data.JSONArray results = checkinData.getJSONArray("results");
    //albums = new String[results.length()][arrayNumberCols];
    for (int i=0; i < 20; i++){
      //for (processing.data.JSONObject entry: results){
        
      ArrayList<String> song_artist = new ArrayList();
      processing.data.JSONObject singleSong = results.getJSONObject(i);
        //System.out.println (singleSong.getString ("wrapperType"));
        //System.out.println (singleSong.getString ("collectionName"));
        //println (singleSong.getInt ("artistId"));
        //println (singleSong.getInt ("collectionId"));
        //System.out.println (singleSong.getInt ("amgArtistId"));
        song_artist.add(singleSong.getString ("trackName"));
        song_artist.add(singleSong.getString ("artistName"));
        println (singleSong.getString ("trackName"));
        //println (singleSong.getString ("collectionName"));
        //println (singleSong.getInt ("trackNumber"));
        println (singleSong);
        ret.add(song_artist);
   }
    
   return ret;
  //}
  /*
    catch (Exception e){
      println ("there's an error");  
  }
  */
}
}