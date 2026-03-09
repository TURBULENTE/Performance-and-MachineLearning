/**
 Performance and AI
 With this example we will trigger an image (or a sequence of images),
 depending on the received classified data.
 Mobile Phone -> Sensors2OSC App ->Wekinator ->Processing
 */

float cd; // A variable where we will save the classified data (cd) incoming from Wekinator

PImage [] kittens; // An image type array variable called "kittens"
PImage backImage; // A image variable for our background image
float rn; //   a variable to create a random number

// Importing library
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

void setup() {
  size(640, 480);  // The size of my canvas
  //fullScreen(); // For full screen visualization.
  
  //frameRate(5); //To change the speed of the processing rendering
  
  oscP5 = new OscP5(this, 12000);
  // Listening IP + Port.
  //"This" refers to the IP of the computer where Processing is running.
  // The second parameter should be the output port previously configured in Wekinator
  backImage= loadImage("galaxy.jpeg");
  image(backImage, 0, 0);

  kittens = new PImage[8]; // Initialize the array with 8 slots (0, 1, 2...)
  // --- We use a for loop to assign an kitten image to each slot in our array --
  for (int i=0; i<kittens.length; i++) {
    kittens[i] = loadImage("kitten/kitten" + i+ ".png");
    println(i);
  }
}

void draw() {
  image(backImage, 0, 0);
  rn= random(8);
  if (cd==2) { // if the classified data equals to 1, then, display the background with color One...
    
    image(kittens[7],width/2-100, height/2-100, 200, 200);
    //image(kittens[int(rn)], width/2-100, height/2-100, 200, 200);
    
  }
}

// - - - - - - - - - - OSC FUNCTIONS - - - - - - - - - - //

void oscEvent(OscMessage theOscMessage) {
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
  cd= theOscMessage.get(0).floatValue();
  println("Value = " + cd);
}
