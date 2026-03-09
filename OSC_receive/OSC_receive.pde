/**
 Performance and AI
 Understanding OSC Messages
 Prof. Citlali Hernández - 2026
 
 In this code we will corroborate that an external device sends OSC messages to our code in Processing.
 To do this, we will need both devices (our computer and the tablet or phone) to be connected to the same Wifi network.
 This code works with the oscP5 library by Andreas Schlegel and more information can be found at: http://www.sojamo.de/oscP5.
 This code is an adaptation of the example called oscP5message from the library.
 */


float a, b, c;

// Import the OSC Library
import oscP5.*;
import netP5.*;

OscP5 oscP5; // Create an object Ascp5 called oscP5
NetAddress myRemoteLocation;

void setup() {

  size(400, 400);
  // Initializing the library.
  //(this = this computer's IP), (5003 = the port Processing will be listening to)
  oscP5 = new OscP5(this, 5001);
}


void draw() {
}


/* Incoming OSC messages to Processing must be read using the oscEvent function,
 which is built into the library.
 Therefore, this function must always be named this way. */

void oscEvent(OscMessage theOscMessage) {
  /* Print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
  //println(theOscMessage.get(0).floatValue());


  //////////////// If using Sensors2OSC:
  
  a= theOscMessage.get(0).floatValue(); // yaw 0, 6
   b= theOscMessage.get(1).floatValue(); // pitch 0.1,3. -0.1, -3.0
   c= theOscMessage.get(2).floatValue(); // roll 0, 1, 0, -1
   println("Valor a= " + a + "   " + "Valor b= " + b + "   " + "Valor c= " + c);
   
   
   
  //////////////// if using ZIGSIM - Gyro

/*
  if (theOscMessage.addrPattern().equals("/ZIGSIM/myMsg/gyro")) {
    a= theOscMessage.get(0).floatValue();
    b= theOscMessage.get(1).floatValue();
    c= theOscMessage.get(2).floatValue();
    println("value a= " + a + "value b= " + b + "value c= " + c);
  }
  */
  
}
