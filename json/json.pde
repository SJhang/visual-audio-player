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
controlP5.Button selectSong, startVis, pauseVis, stopVis, changeVis;
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
AudioRenderer radar, vortex, iso, col, circle;
AudioMetaData meta;
AudioRenderer[] visuals; 
BeatDetect beat;
int select = 0;
BufferedReader reader;
PrintWriter output;
String file_name;
String songName = "5sec.mp3";
boolean playing = false;
JFileChooser file_chooser = new JFileChooser();
/////////////////////////////////////////////////////////////
boolean start = false;
String current_gui = "offline";
String artistInput, youtubeLink;
boolean youtubeLinkClick = false;
PFont pfont;
String inputAddr;


void setup(){
  size(800,700,P2D);
  noStroke();
  background(0);
  minim = new Minim(this);
  groove = minim.loadFile("5sec.mp3");
  groove.play(); 
  //playing = true;
  meta = groove.getMetaData();
  beat = new BeatDetect(groove.bufferSize(), groove.sampleRate());
  beat.setSensitivity(300);

  // setup renderers
  vortex = new feiyuRenderer(groove);
  radar = new RadarRenderer(groove);
  iso = new IsometricRenderer(groove);
  col = new ColorRenderer(groove);
  circle = new CircleRenderer(groove);
  visuals = new AudioRenderer[] {vortex,radar,col, circle};
  
  // activate first renderer in list
  select = 0;
  groove.addListener(visuals[select]);
  visuals[select].setup();
  
  // main page
  cp5 = new ControlP5(this);

  fill(255);
  textSize(100);
  textAlign(CENTER, CENTER);
  text("YouTook", 400, 300);
  textAlign(LEFT);
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
    offlineGUI.display();
    offlineGUI.show();   
    println("offline displayed");
  }
  else if(n == 1){
    song_stop();
    offlineGUI.hide();
    onlineGUI.display();
    onlineGUI.show();
    println("online displayed");
  }

}

void openFile() {
  try {
    SwingUtilities. invokeLater(new Runnable() {
      public void run() {
 
        int return_val = file_chooser.showOpenDialog(null);
        if ( return_val == JFileChooser.CANCEL_OPTION )   
        println("canceled");
        if ( return_val == JFileChooser.ERROR_OPTION )   
        println("error");      
        if ( return_val == JFileChooser.APPROVE_OPTION ) {
          println("approved");
          File file = file_chooser.getSelectedFile();
          file_name = file.getAbsolutePath();         
          songName = file.getName().split("\\.")[0];   
          groove = minim.loadFile(file_name);
        } else {
          file_name = "none";
        }
        println(songName);
        groove.play();
      }
    }
    );
  }
  catch (Exception e) {
    e.printStackTrace();
  }
}

public void keyReleased() {
  if ( key == 'o') {
    
    //pause when uploading file
     groove.pause();
    
    openFile();
  }
  if( key == 'c'){
    noLoop();
    switchBackground();
    loop();
  }
  if(key == 'p' && playing == true){
    groove.pause();  
    playing = false;
  }
  if(key == 'r' && playing == false){
    groove.play();
    playing = true;
  }
  if(key == 'x'){
    song_stop();
    
  }
}
public void switchBackground(){
   groove.removeListener(visuals[select]);
   select++;
   select %= visuals.length;
   groove.addListener(visuals[select]);
   visuals[select].setup();  
}

void song_stop()
{
  playing = false;
  groove.pause();
  minim.stop();
  //super.stop();
  background(255);
  navigate.show();
  offlineGUI.display();
  offlineGUI.show();
  
}

void draw(){
  if(songName.length()!=0 && playing){  
    offlineGUI.display2();
    pushMatrix();
    visuals[select].draw();
    navigate.show();
    
    offlineGUI.show();
    popMatrix();
    
  }
}