class Youtube{
  String artist, song;
  
  Youtube (String _artist, String _song){
    artist = _artist.trim().replaceAll(" ", "+");
    song = _song.trim().replaceAll(" ", "+");
  }
  
  String getYoutubeLink (){
    String youtubeInput = artist+ "+" + song;
    String baseURL = "https://www.youtube.com/results?search_query=";
    String youtubeURL = baseURL + youtubeInput;
    println (youtubeURL);
    return (youtubeURL);
  }
}