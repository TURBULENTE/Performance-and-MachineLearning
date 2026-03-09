/**
 Performance and AI
 With this example we will trigger sounds using the "Sound" Library.
 The sound file chosen will depend on the received classified data.
 Mobile Phone -> Sensors2OSC App ->Wekinator ->Processing -> Sound!
 */



import processing.sound.*;
SoundFile[] file;
import oscP5.*;
import netP5.*;
OscP5 oscP5;
NetAddress myRemoteLocation;

int numsounds = 5;
int backgroundColor[] = {255, 255, 255};
float cd;
float previousCd = -1; 

void setup() {
  size(640, 360);
  file = new SoundFile[numsounds];
  for (int i = 0; i < numsounds; i++) {
    file[i] = new SoundFile(this, (i+1) + ".aif");
  }
  oscP5 = new OscP5(this, 12000);
}

void draw() {
  background(backgroundColor[0], backgroundColor[1], backgroundColor[2]);
 
 // This is a state machine to call the triggeringSound() function only if cd changed
  if (cd != previousCd) {  
    triggeringSound();
    previousCd = cd; // updates to last value
  }
}

void triggeringSound() {
  boolean state = true;
  switch(int(cd)) {
  case 1:
    file[0].play(0.5, 1.0); //the parameters of play are (rate, amplitude). Rate= Speed, Amplitude=volume)
    break;
  case 2:
    file[1].play(0.5, 1.0);
    break;
  case 3:
    file[int(random(5))].play(random(1.0), random(1.0));
    break;
  default:
    state = false;
  }
  if (state) {
    for (int i = 0; i < 3; i++) {
      backgroundColor[i] = int(random(255));
    }
  }
}


void oscEvent(OscMessage theOscMessage) {
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
  cd = theOscMessage.get(0).floatValue();
  println("Value = " + cd);
}
