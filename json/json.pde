import processing.data.JSONObject;
import http.requests.GetRequest;
ITunes itunesResults;
ChartLyrics lyrics;
Youtube youtubeLink;

void setup(){
  String artistInput = "michael jackson";
  
  itunesResults = new ITunes(artistInput);
  ArrayList<String> results = itunesResults.getSongs();
  println (results);
  
  String songInput = results.get(1);
  lyrics = new ChartLyrics(artistInput, songInput);
  String lyricsResults = lyrics.getLyrics();
  println (lyricsResults);
  
  youtubeLink = new Youtube(artistInput, songInput);
  String linkResult = youtubeLink.getYoutubeLink();
  println (linkResult);
}