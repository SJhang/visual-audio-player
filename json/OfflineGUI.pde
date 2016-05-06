class OfflineGUI{
  Textfield titleVis;
  controlP5.Button selectSong, startVis, pauseVis, stopVis;
  ControlP5 cp5;
  OfflineGUI(ControlP5 cp5){
      ////////OFFLINE GUI/////////////////
      selectSong = cp5.addButton("choose")
                      .setBroadcast(false)
                      .setPosition(50,130)
                      .activateBy(ControlP5.RELEASE)
                      .setSize(150,30)
                      .plugTo(this, "choose")
                      .setBroadcast(true)
                      .hide()
                      ;
                      
      startVis = cp5.addButton("startVis")
                    .setBroadcast(false)
                    .setPosition(230,130)
                    .activateBy(ControlP5.RELEASE)
                    .setSize(150,30)
                    .setLabel("START")
                    .plugTo("startVis")
                    .setBroadcast(true)
                    .hide()
                    ;
                    
      pauseVis = cp5.addButton("pauseVis")
                    .setBroadcast(false)
                    .setPosition(410,130)
                    .activateBy(ControlP5.RELEASE)
                    .setSize(150,30)
                    .setLabel ("PAUSE")
                    .plugTo("pauseVis")
                    .setBroadcast(true)
                    .hide()
                    ;
      stopVis = cp5.addButton("stopVis")
                   .setBroadcast(false)
                   .setPosition(590,130)
                   .activateBy(ControlP5.RELEASE)
                   .setSize(150,30)
                   .setLabel("STOP")
                   .plugTo("stopVis")
                   .setBroadcast(true)
                   .hide()
                   ;
                   
      titleVis = cp5.addTextfield("Title of the song")
                         .setPosition(50, 90)
                         .setSize(500, 20)
                         .setFocus(true)
                         .setAutoClear(false)
                       //.setFont(createFont("arial",12,true))
                         .setColor(color(255,255,255))
                         .hide()
                         ;                  
     titleVis.getCaptionLabel().setColor(color(10,20,30,140));
     

  }
  void choose(int n){
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
  
  void startVis(int n){
    playing = true;
    meta = groove.getMetaData();
    beat = new BeatDetect(groove.bufferSize(), groove.sampleRate());
    beat.setSensitivity(300);
   
  }
  
  void pauseVis(int n){
  }
  void stopVis(int n){
  }
  

  void display(){
    background(200);
    fill(55);
    textAlign(LEFT);
    textSize(30);
    text("Local Player",30,70);
  }
  
  public void show(){
    selectSong.show();
    startVis.show();
    pauseVis.show();
    stopVis.show();
    titleVis.show();
  }
  
  public void hide(){
    selectSong.hide();
    startVis.hide();
    pauseVis.hide();
    stopVis.hide();
    titleVis.hide();
  }
}