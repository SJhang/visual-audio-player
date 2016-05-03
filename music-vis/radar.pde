
class RadarRenderer extends AudioRenderer {
  int radius = 150;
  float nScale = 200;
  float noiseMulti = 300;
  float h = 0,s = 100, b = 100;
  int rotations;
  
  RadarRenderer(AudioSource source) {
    rotations =  (int) source.sampleRate() / source.bufferSize();
  }
  
  void setup() {
    colorMode(HSB, 360, 100, 20);
    background(0);
    
    
  }
  
  synchronized void draw()
  {
    if(left != null) {
    noStroke();
    fill(0);
    rect(0, 0, width, height);
    translate(width/2, height/2);
    beat.detect(groove.mix);
    if (beat.isKick()) {
      noiseMulti = 300;
      nScale = 150;
    } else {
      if (nScale > 100) nScale *= 0.9;
      noiseMulti *= 0.5;
    }
 
    for (int lat = -90; lat < 90; lat+=2)
    {
      for (int lng = -180; lng < 180; lng+=2)
      {
        float _lat = radians(lat);  
        float _lng = radians(lng);  
        // noise
        float n = noise(_lat * noiseMulti / 100, _lng * noiseMulti / 100 + millis() );
 
        float x = (radius + n * nScale) * cos(_lat) * cos(_lng);
        float y = (radius + n * nScale) * sin(_lat) * (-1);
        float z = (radius + n * nScale) * cos(_lat) * sin(_lng);
        PVector pos = new PVector(x,y,z);
        float dist = PVector.dist(pos,new PVector(0,0,0));
        //print(" "+dist);
        int time = second()%5;
        stroke(dist-time*50,100,100);
        point(x, y, z);
      }
    }
      
    }
  }
}