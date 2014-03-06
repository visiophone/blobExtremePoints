// CV blur
float blur=2.0;
//show hide cv windows
boolean cvFeed=true;
boolean cvBlob=true;
boolean cvExtShape=true;
//show gui
boolean gui=false;
//paint backgournd
boolean back=true;

int stepPoints=1;


void GUI(){ 
   cp5 = new ControlP5(this);
   
  // add a horizontal sliders, the value of this slider will be linked
   
   cp5.addToggle("cvFeed")
     .setPosition(20,510)
     .setSize(15,15)
     ;
     
       cp5.addToggle("cvBlob")
     .setPosition(60,510)
     .setSize(15,15)
     ;
     
      cp5.addToggle("cvExtShape")
     .setPosition(100,510)
     .setSize(15,15)
     ;
   
     cp5.addSlider("blur")
     .setPosition(20 ,540)
     .setSize(150,15)
     .setRange(0,10.0)   
     ; 
     
       cp5.addSlider("stepPoints")
     .setPosition(20 ,570)
     .setSize(150,15)
     .setRange(1,50)   
     ; 

  
   
}


//save propireteis
void keyPressed() {
  // 1 - SAVE  // 2 load
  if (key=='1') {
    cp5.saveProperties(("hello.properties"));
  } 
  else if (key=='2') {
    cp5.loadProperties(("hello.properties"));
  }
  
   else if (key=='g') gui=!gui;
   
   else if (key=='b') back=!back;

}
