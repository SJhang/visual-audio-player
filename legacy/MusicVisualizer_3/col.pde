class ColorRenderer extends AudioRenderer {
  int frame = 0;
  int r_weight_base = 100;

  float music_sum = 1024;
  float auto_add = 0;

  color [] c = new color[3];

  PFont font;
  int rotations;

  ColorRenderer(AudioSource source) {
    rotations =  (int) source.sampleRate() / source.bufferSize();
  }
  
  void setup() {
    colorMode(RGB, TWO_PI * rotations, 1, 1);
    background(0);
    smooth();
    c[0] = color(213, 129, 129);
    c[1] = color(140);
    c[2] = color(167, 176, 233);
  }
  
  synchronized void draw()
  {
    if(left != null) {
      translate(width/2, height/2);
      fill(160);
      rotate(auto_add);
  
      for(int i = 0; i < music_sum; i++){
    
      int sound_weight = int(groove.left.get(i) * 50);
      noStroke();
      noFill();
      
      rotate(TWO_PI/3);
      if(i % 1 == 0){
        pushMatrix();
          rotate(TWO_PI*0.00020*i);
          stroke(c[i%3], map(i, 0, int(music_sum), 0, 150));
          strokeWeight(1);
          ellipse(r_weight_base*3, 0, sound_weight * 1.5, sound_weight * 1.5);
        popMatrix();
        pushMatrix();
          rotate(TWO_PI*0.00020*i);
          stroke(c[i%3], map(i, 0, int(music_sum), 0, 150));
          strokeWeight(1);
          ellipse(r_weight_base*2, 0, sound_weight / 1.5, sound_weight / 1.5);
        popMatrix();
      }
  }
  auto_add += 0.018;
}
    
    
    }
  }