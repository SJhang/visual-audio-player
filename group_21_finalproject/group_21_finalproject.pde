import controlP5.*;
import java.util.*;
ControlP5 cp5;
XML lyric_results;
boolean start = false;
String current_gui = "offline";
controlP5.Button start_button;
controlP5.ButtonBar nav;
controlP5.ScrollableList results;
Textarea lyrics;
local_gui offline_gui = new local_gui(0,30,width,height-30);
online_gui online_gui = new online_gui(0,30,width,height-30);
itunes artist_search;
chartlyrics lyric_search;


String url = "http://api.chartlyrics.com/apiv1.asmx/SearchLyric?artist=John%20Paul%20Young&song=Love%20Is%20in%20the%20Air";

PFont pfont;

void setup(){
  size(800,700);
  noStroke();
  background(255);
  // default start page - main menu
  cp5 = new ControlP5(this);
  fill(50);
  textSize(100);
  textAlign(CENTER, CENTER);
  text("YouTook", 400, 300);
  start_button = cp5.addButton("Start")
  // to prevent a controller from triggering an event, use setBroadcast(false)
     .setBroadcast(false)
     .setValue(50)
     .setPosition(300,400)
     .activateBy(ControlP5.PRESS)
     .setSize(200,40)
     .setBroadcast(true)
     ;
  pfont = createFont("Arial",20,true); // use true/false for smooth/no-smooth
  ControlFont font = new ControlFont(pfont,241);
  
  // change the font and content of the captionlabels 
  // for both buttons create earlier.
  cp5.getController("Start")
     .getCaptionLabel()
     .setFont(font)
     .toUpperCase(true)
     .setSize(20)
     ;
  
  font = new ControlFont(pfont,10);
  nav = cp5.addButtonBar("nav")
      .setPosition(0,0)
      .setSize(width,30)
      .setFont(font)
      .addItems(split("Offline Mode;Online Mode", ";"))
      .hide()
      ;
      
  nav.onMove(new CallbackListener(){
    public void controlEvent(CallbackEvent ev) {
      ButtonBar bar = (ButtonBar)ev.getController();
      //println("hello ",bar.hover());
    }
  });
  
  results = cp5.addScrollableList("results")
   .setPosition(50, 155)
   .setSize(325, 300)
   .setBarHeight(20)
   .setItemHeight(20)
   .setOpen(false)
   .hide()
   //.setType(ScrollableList.LIST) // currently supported DROPDOWN and LIST
   ;
  
  lyrics = cp5.addTextarea("lyrics")
    .setPosition(425,155)
    .setSize(325,500)
    .setFont(createFont("arial",12))
    .setLineHeight(14)
    .setColor(color(128))
    .setColorBackground(color(255,100))
    .setColorForeground(color(255,100))
    .hide()
    ;
  
}

public void controlEvent(ControlEvent theEvent) {
  if(theEvent.getController().getName() == "Enter Artist Name"){
    online_gui.show_results();
    artist_search = new itunes(theEvent.getController().getStringValue());
    ArrayList<ArrayList<String>> song_list = artist_search.getSongs();
    ArrayList<String> song_artist = new ArrayList();
    for(ArrayList i : song_list){
      song_artist.add(i.get(0) + " : " + i.get(1));
    }
    
    println(song_artist);
    cp5.get(ScrollableList.class, "results").setItems(song_artist);
  }
  println(theEvent.getController().getName());
}

// function colorA will receive changes from 
// controller with name colorA
public void Start(int value) {
  println("a button event from colorA: " + value);
  start_button.hide();
  start = true;
  background(255);
}

public void results(int n) {
  lyrics.show();
  /* request the selected item based on index n */
  println(n, cp5.get(ScrollableList.class, "results").getItem(n));
  Map info = cp5.get(ScrollableList.class, "results").getItem(n);
  String song_artist = (String)info.get("name");
  String[] temp = song_artist.split(":");
  temp[0] = temp[0].trim();
  temp[1] = temp[1].trim();
  
  
  lyric_search = new chartlyrics(temp[0],temp[1]);
  lyric_search.getLyrics();
  temp[0] = temp[0].replaceAll(" ","+");
  temp[0] = temp[0].replaceAll("\\(.*\\)", ""); 
  temp[0] = temp[0].replaceAll("\\[.*\\]", ""); 
  temp[0] = temp[0].trim();
  temp[1] = temp[1].replaceAll(" ","+"); 
  println(temp[0]);
  println(temp[1]);
  String youtube_url = "https://www.youtube.com/results?search_query=" + temp[0] + "+" + temp[1];
  println(youtube_url);  
  link(youtube_url);
  
  println("!!!pass");
  
  /* here an item is stored as a Map  with the following key-value pairs:
   * name, the given name of the item
   * text, the given text of the item by default the same as name
   * value, the given value of the item, can be changed by using .getItem(n).put("value", "abc"); a value here is of type Object therefore can be anything
   * color, the given color of the item, how to change, see below
   * view, a customizable view, is of type CDrawable 
   */
  
  CColor c = new CColor();
  c.setBackground(color(255,0,0));
  cp5.get(ScrollableList.class, "results").getItem(n).put("color", c);
  
}

public void nav(int n) {
  if(n == 0){
    //deploy local_gui class
    //hide online_gui class
    current_gui = "offline";
    online_gui.hide();
    offline_gui.display();
    println("offline displayed");
  }
  else if(n == 1){
    //deploy online_gui class
    //hide local_gui class
    current_gui = "online";
    offline_gui.hide();
    online_gui.display();
    println("online displayed");
  }
}
void draw(){
  // interface between the 2 functions will not be displayed until the main page button has been pressed
  if(start == true){
    nav.show();
    
  }
}