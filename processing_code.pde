//import serial library and minim (sound) library
import processing.serial.*;
import ddf.minim.*;

//sound levels
float level1 = 0;
float level2 = -30;

//color variable for bg
float hue;

//connection to Arduino
int lf = 10;   
String myString = null;
Serial myPort;  
int sensorValue = 0;


//audio players
Minim minim;
AudioPlayer ring;
AudioPlayer bird;

void setup() {

  // Connection to Arduino 
  printArray(Serial.list());
  myPort = new Serial(this, Serial.list()[5], 9600);
  myPort.clear();
  myString = myPort.readStringUntil(lf);
  myString = null;

  size(100, 100);

  //load mp3's and loop
  minim = new Minim(this);
  ring = minim.loadFile("phone.mp3");
  ring.loop();

  bird = minim.loadFile("mockingbird.mp3");
  bird.loop();

  //print gain and volume levels
  println(ring.getControls());
  println(bird.getControls());
}

void draw() {

  //set bg to mapped sensor variable
  background(hue-25, hue-50, hue+75);

  //set volume(gain) of mp3's to mapped sensor output
  ring.setGain(level2);
  bird.setGain(level1);

  //map sensor output to usable values for volume
  level1 = map(sensorValue, 10, 300, -20, -30);
  level2 = map(sensorValue, 10, 300, -50, 6);

  //map sensor output to usable rgb value
  hue = map(sensorValue, 42, 570, 0, 255);

  println(sensorValue);

  //connecting to Arduino and collecting sensor output values
  while (myPort.available() > 0) {

    myString = myPort.readStringUntil(lf);

    if (myString != null) {
      myString = myString.trim();

      if (myString.length() > 0) {
        try {
          sensorValue = Integer.parseInt(myString);
        } 
        catch(Exception e) {
        }
      }
    }
  }
}

//Arduino connection code adapted from https://gist.github.com/timpulver/5ba4a29cddd543b4a900   ty ty
