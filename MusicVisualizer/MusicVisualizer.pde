
import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer groove;
AudioRenderer radar, vortex, iso, col, circle;
AudioMetaData meta;
AudioRenderer[] visuals; 
BeatDetect beat;
int select;

boolean isInput;
 
void setup()
{
  // setup graphics
  size(700, 700, P2D);
  smooth(); 
  
  isInput = false;
  // setup file selecter
  selectInput("Select a file to process:", "fileSelected");

    
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    String inputAddr = selection.getAbsolutePath();
    println(inputAddr);
    // setup player
    minim = new Minim(this);
    groove = minim.loadFile(inputAddr);
    groove.loop();  
    meta = groove.getMetaData();
    beat = new BeatDetect(groove.bufferSize(), groove.sampleRate());
    beat.setSensitivity(300);
  
    // setup renderers
    vortex = new feiyuRenderer(groove);
    radar = new RadarRenderer(groove);
    iso = new IsometricRenderer(groove);
    col = new ColorRenderer(groove);
    circle = new CircleRenderer(groove);
    visuals = new AudioRenderer[] {vortex, iso, col, circle, radar};
    
    // activate first renderer in list
    select = 0;
    groove.addListener(visuals[select]);
    visuals[select].setup();
    
    isInput = true;
  }
}

void draw()
{
  if (isInput == true) {
    visuals[select].draw();
  }
}
 
void keyPressed() {
   groove.removeListener(visuals[select]);
   select++;
   select %= visuals.length;
   groove.addListener(visuals[select]);
   visuals[select].setup();
}

void stop()
{
  groove.close();
  minim.stop();
  super.stop();
}