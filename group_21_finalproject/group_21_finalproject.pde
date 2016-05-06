import controlP5.*;
import java.util.*;
ControlP5 cp5;
boolean start = false;
String current_gui = "offline";
controlP5.Button start_button;
controlP5.ButtonBar nav;
controlP5.ScrollableList results;
Textarea lyrics;
local_gui offline_gui = new local_gui(0,30,width,height-30);
online_gui online_gui = new online_gui(0,30,width,height-30);
ITunes itunesResult;
ChartLyrics lyricsResult;
Youtube youtubeResult;
controlP5.Button buttonToYoutube;
controlP5.Knob timer;
String artistInput, youtubeLink;
PFont pfont;

void setup(){
  size(800,700);
  noStroke();
  background(255);
  minim = new Minim(this);
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
    
  buttonToYoutube = cp5.addButton("Youtube")
  // to prevent a controller from triggering an event, use setBroadcast(false)
    .setBroadcast(false)
    .setValue(50)
    .setPosition(50,500)
    .setValue(0)
    .activateBy(ControlP5.RELEASE)
    .setSize(150,40)
    .setBroadcast(true)
    .hide()
  ;
  timer = cp5.addKnob ("timer")
    .setRange (0, 255)
    //.setValue (50)
    .setPosition (600, 50)
    .setRadius (50)
    .setNumberOfTickMarks(10)
    .setTickMarkLength(4)
    //.snapToTickMarks(true)
    //.setColorForeground(color(255, 100))
    //.setColorBackground(color(255, 100))
    //.setColorActive(color(255,255,0))
    .setDragDirection(Knob.HORIZONTAL)
    .hide()
  ;
}

public void controlEvent(ControlEvent theEvent) {
  if(theEvent.getController().getName() == "Enter Artist Name"){
    online_gui.show_results();
    artistInput = theEvent.getController().getStringValue();
    itunesResult = new ITunes(artistInput);
    ArrayList<String> songResult = itunesResult.getSongs();
    println (songResult);
    ArrayList<String> queryResult = new ArrayList();
    for (int i=1; i<songResult.size(); i++){
      queryResult.add(songResult.get(0) + ":" + songResult.get(i));
    }
    println (queryResult);
    cp5.get(ScrollableList.class, "results").setItems(queryResult);
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
  
  
  lyricsResult = new ChartLyrics(temp[0],temp[1]);
  String lyricsText = lyricsResult.getLyrics();
  lyricsResult.display();
  if (lyricsText == ""){
    lyrics.clear();
    lyrics.append ("Lyrics not found :(");
  } else{
    lyrics.clear();
    lyrics.append (lyricsText);
  }
  
  youtubeResult = new Youtube (temp[0], temp[1]);
  youtubeLink = youtubeResult.getYoutubeLink();
  buttonToYoutube.show();
  
  
  
     
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
    timer.show();
    println("online displayed");
  }
}
public void Youtube (){
  link (youtubeLink);
}
public void timer (int value){
  
}

void draw(){
  // interface between the 2 functions will not be displayed until the main page button has been pressed
  if(start == true){
    nav.show();
  }
}
