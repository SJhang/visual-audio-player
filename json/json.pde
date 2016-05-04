import processing.data.JSONObject;
import http.requests.GetRequest;
ITunes itunesResults;
ChartLyrics lyrics;
Youtube youtubeLink;

void setup(){
  size(600, 300);
  
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
  youtubeLink.getVideo();
}