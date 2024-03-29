
class feiyuRenderer extends AudioRenderer {
  
  int  r = 150;
  float rad = 30;
  
  int rotations;

  feiyuRenderer(AudioSource source) {
    rotations =  (int) source.sampleRate() / source.bufferSize();
  }
  
  void setup() {
    colorMode(RGB, TWO_PI * rotations, 1, 1);
    background(0);
  }
  
  synchronized void draw()
  {
    if(left != null) {
      float t = map(mouseX, 0, width, 0, 1);
    beat.detect(groove.mix);
    fill(#1A1F18, 20);
    noStroke();
    rect(0, 0, width, height);
    translate(width/2, height/2);
    noFill();
    fill(-1, 10);
    if (beat.isOnset()) rad = rad*0.9;
    else rad = 70;
    ellipse(0, 0, 2*rad, 2*rad);
    stroke(-1, 50);
    int bsize = groove.bufferSize();
    for (int i = 0; i < bsize - 1; i+=5)
    {
      float x = (r)*cos(i*2*PI/bsize);
      float y = (r)*sin(i*2*PI/bsize);
      float x2 = (r + groove.left.get(i)*100)*cos(i*2*PI/bsize);
      float y2 = (r + groove.left.get(i)*100)*sin(i*2*PI/bsize);
      line(x, y, x2, y2);
    }
    beginShape();
    noFill();
    stroke(-1, 50);
    for (int i = 0; i < bsize; i+=30)
    {
      float x2 = (r + groove.left.get(i)*100)*cos(i*2*PI/bsize);
      float y2 = (r + groove.left.get(i)*100)*sin(i*2*PI/bsize);
      vertex(x2, y2);
      pushStyle();
      stroke(-1);
      strokeWeight(2);
      point(x2, y2);
      popStyle();
    }
    endShape();
      
    }
  }
}