import processing.data.JSONObject;
//import http.requests.GetRequest;
import controlP5.*;
import java.util.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import javax.swing.JFileChooser;
import javax.swing.SwingUtilities;
///////////////////////////////////////////////////////////////
ControlP5 cp5;
controlP5.ButtonBar navigate;
controlP5.Button start_button;
ControlWindow controlWindow;
Canvas cc;
//////////////////////////////////////////////////////////////
ITunes itunesResult;
ChartLyrics lyricsResult;
Youtube youtubeResult;
OfflineGUI offlineGUI;
OnlineGUI onlineGUI;
//////////////////////////////////////////////////////////////
Minim minim;
AudioPlayer groove;
//AudioRenderer radar, vortex, iso, col, circle;
AudioMetaData meta;
//AudioRenderer[] visuals; 
BeatDetect beat;
BufferedReader reader;
PrintWriter output;
/////////////////////////////////////////////////////////////
MouseTimer mouse;
boolean start = false;
String current_gui = "offline";
String artistInput, youtubeLink;
boolean youtubeLinkClick = false;
PFont pfont;
String inputAddr;
boolean playing = false;

void setup(){
  size(800,700);
  noStroke();
  background(255);
  
  // main page
  cp5 = new ControlP5(this);
  mouse = new MouseTimer();
  fill(50);
  textSize(100);
  textAlign(CENTER, CENTER);
  text("YouTook", 400, 300);
  offlineGUI = new OfflineGUI(cp5);
  onlineGUI = new OnlineGUI(cp5);
  
  
  start_button = cp5.addButton("Start")
    .setBroadcast(false)
    .setPosition(300,400)
    .activateBy(ControlP5.PRESS)
    .setSize(200,40)
    .setValue(0)
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
  navigate = cp5.addButtonBar("nav")
      .setPosition(0,0)
      .setSize(width,30)
      .setFont(font)
      .addItems(split("Offline Mode;Online Mode", ";"))
      .hide();
  
}

public void Start(int value) {
  start_button.hide();
  navigate.show();
  background(255);
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.getController().getName().equals("Enter Artist Name")){
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
    cp5.get(ScrollableList.class, "results").show();
    text("Click the top row to change songs",50,150);
  }
  
  println(theEvent.getController().getName());
}  



public void nav(int n) {
  if(n == 0){
 //hide online gui and deploy offline gui
    onlineGUI.hide();
    offlineGUI.update();
    offlineGUI.show();
    
    println("offline displayed");
  }
  else if(n == 1){
    onlineGUI.display();
    onlineGUI.show();
    offlineGUI.hide();
    println("online displayed");
  }

}

void draw(){

  
}