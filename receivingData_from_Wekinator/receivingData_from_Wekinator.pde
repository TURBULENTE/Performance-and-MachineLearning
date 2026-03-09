/**
 Performance and AI
 Understanding OSC Messages
 With this example we will assign a simple visual behaviour to our sketch, depending on the received classified data.
 Mobile Phone -> Sensors2OSC App ->Wekinator ->Processing
 */

float cd; // A variable where we will save the classified data (cd) incoming from Wekinator

color colorOne= #e8e8e8;
color colorTwo= #ffff80;
color colorThree= #9580ff;
//Advanced: You could use an array: color[] myColor = {#e8e8e8, #ffff80, #9580ff};

// Importing Library
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

void setup() {
  size(400, 400);  // The size of my canvas
  //fullScreen(); // For full screen visualization.
  oscP5 = new OscP5(this, 12000);
  // Listening IP + Port.
  //"This" refers to the IP of the computer where Processing is running.
  // The second parameter should be the output port previously configured in Wekinator
}

void draw() {

 

  if (cd==1) { // if the classified data equals to 1, then, display the background with color One...
    background(colorOne);
  } else if (cd==2) { // if the classified data equals to 2, then, display the background with color Two...
    background(colorTwo);
  } else if (cd==3) { // if the classified data equals to 3, then, display the background with color Three
    background(colorThree);
  }
  /* If using a color array:
   background(miColor[int(clase)]);
   */
}

// - - - - - - - - - - OSC FUNCTIONS - - - - - - - - - - //

void oscEvent(OscMessage theOscMessage) {
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
  cd= theOscMessage.get(0).floatValue();
  println("Value = " + cd);
}
