
import ddf.minim.*;
import ddf.minim.analysis.*;
import javax.swing.JFileChooser;
import javax.swing.SwingUtilities;


Minim minim;
AudioPlayer groove;
AudioRenderer radar, vortex, iso, col, circle;
AudioMetaData meta;
AudioRenderer[] visuals; 
BeatDetect beat;
int select;
boolean playing = false;
String songName  = "07 Talking To The Moon";


 
void setup()
{
  // setup graphics
  size(700, 700, P2D);
  smooth(); 
  // setup player
  minim = new Minim(this);
  groove = minim.loadFile("07 Talking To The Moon.mp3");
  groove.loop(); 
  playing = true;
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

}
 
void draw()
{
  if(songName.length()!=0)
   displaySongName();
   visuals[select].draw();
}
 
 
void displaySongName(){
   textSize(32);
  float cw = textWidth(songName);
  text(songName,(width-cw)/2,50);
  fill(0, 102, 153);  
}
 

 


void stop()
{
  groove.close();
  minim.stop();
  super.stop();
}


String file_name;
JFileChooser file_chooser = new JFileChooser();
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
void switchBackground(){
   groove.removeListener(visuals[select]);
   select++;
   select %= visuals.length;
   groove.addListener(visuals[select]);
   visuals[select].setup();  
}



void keyReleased() {
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
  
  
  
}