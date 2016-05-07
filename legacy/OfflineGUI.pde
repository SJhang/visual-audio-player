class OfflineGUI{
  Textfield titleVis;
  controlP5.Button selectSong, startVis, pauseVis, stopVis;
  ControlP5 cp5;
  OfflineGUI(ControlP5 cp5){
      ////////OFFLINE GUI/////////////////
      selectSong = cp5.addButton("choose")
                      .setBroadcast(false)
                      .setPosition(30,100)
                      .activateBy(ControlP5.RELEASE)
                      .setSize(150,30)
                      .plugTo(this, "choose")
                      .setBroadcast(true)
                      .hide()
                      ;
                      
      startVis = cp5.addButton("startVis")
                    .setBroadcast(false)
                    .setPosition(210,100)
                    .activateBy(ControlP5.RELEASE)
                    .setSize(150,30)
                    .setLabel("START")
                    .plugTo("startVis")
                    .setBroadcast(true)
                    .hide()
                    ;
                    
      pauseVis = cp5.addButton("pauseVis")
                    .setBroadcast(false)
                    .setPosition(390,100)
                    .activateBy(ControlP5.RELEASE)
                    .setSize(150,30)
                    .setLabel ("PAUSE")
                    .plugTo("pauseVis")
                    .setBroadcast(true)
                    .hide()
                    ;
      stopVis = cp5.addButton("stopVis")
                   .setBroadcast(false)
                   .setPosition(570,100)
                   .activateBy(ControlP5.RELEASE)
                   .setSize(150,30)
                   .setLabel("STOP")
                   .plugTo("stopVis")
                   .setBroadcast(true)
                   .hide()
                   ;
                   
      titleVis = cp5.addTextfield("Title of the song")
                         .setPosition(30, 60)
                         .setSize(500, 20)
                         .setFocus(true)
                         .setAutoClear(false)
                       //.setFont(createFont("arial",12,true))
                         .setColor(color(255,255,255))
                         .hide()
                         ;                  
     titleVis.getCaptionLabel().setColor(color(10,20,30,140));
     

  }
  
  String file_name;
  JFileChooser file_chooser = new JFileChooser();
  void  choose(int n){
    //selectInput("Select a file to process:", "fileSelected");
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
          //songName = file.getName().split("\\.")[0];   
          groove = minim.loadFile(file_name);
        } else {
          file_name = "none";
        }
        //println(songName);
        groove.play();
      }
    }
    );
  }
  catch (Exception e) {
    e.printStackTrace();
  }
  //String[] args = {"hello"};
    //SecondApplet sa = new SecondApplet();
    //PApplet.runSketch(args, sa);
}
  
//public class SecondApplet extends PApplet{
  //public void settings(){
    //size(200,100);
  
  //}
  //public void draw(){
  //background(255);
  //fill(0);
  //}

//}
  
  
  
  void startVis(int n){
    minim = new Minim(this);
    groove = minim.loadFile(inputAddr);
    groove.loop(); 
    playing = true;
    meta = groove.getMetaData();
    beat = new BeatDetect(groove.bufferSize(), groove.sampleRate());
    beat.setSensitivity(300);
  }
  void pauseVis(int n){
  }
  void stopVis(int n){
  }
    
  void update(){
    background(200);
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