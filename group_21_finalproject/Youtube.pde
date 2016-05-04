import http.requests.*;
import processing.data.JSONObject;


class Youtube{
  String artist, song, youtubeLink;
  
  Youtube (String _artist, String _song){
    artist = _artist.trim().replaceAll(" ", "+");
    song = _song.trim().replaceAll(" ", "+");
    youtubeLink = "";
  }
  
  String getYoutubeLink(){
    String youtubeInput = artist+ "+" + song;
    String baseURL = "https://www.youtube.com/results?search_query=";
    String youtubeLink = baseURL + youtubeInput;
    println (youtubeLink);
    return (youtubeLink);
  }
  
  void getVideo(){
    GetRequest get = new GetRequest(getYoutubeLink());
    get.send();
    get.getContent();
    String data = get.getContent();
    println (data);
  }
}