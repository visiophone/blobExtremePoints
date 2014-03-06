/*
Development of a CV tool to track the extreme ends points in blobs. To be use in a real time perforamance to track different kinds of shapes (hands, bodies, dogs,);
Specificly usefull for stage perfomance with top cameras. 
[WWW.VISIOPHONE-LAB.COM]

Using:
Lee Byron's Mesh Lib [http://www.leebyron.com/else/mesh/]  (for the Convex Hull)
V3G's BlobDetection Lib [http://www.v3ga.net/processing/BlobDetection/index-page-home.html] (for blob detection)
Andreas Schlegel's ControlP5 lib [http://www.sojamo.de/libraries/controlP5/#about] (for GUI) 
TOXIX's Libs [http://toxiclibs.org/] ( for ... ? !!? stuff )
*/

import megamu.mesh.*;
import processing.video.*;
import blobDetection.*; // blobs
import controlP5.*; //GUI

//Toxi Geo stuff
import toxi.geom.*;
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;

BlobDetection theBlobDetection; // declare BlobDetection object
ControlP5 cp5; //GUI

// PImage to hold incoming imagery and smaller one for blob detection
PImage cam, blobs;
int nrBlobs;

// the kinect's dimensions to be used later on for calculations
int vidWidth = 320;
int vidHeight = 240;

//import movie
Movie movie;

void setup() {
  size(1024, 768);
 background(0);
  
  GUI();//Start GUI
  cp5.loadProperties(("hello.properties"));
  

 
// Load and play the video in a loop
movie = new Movie(this, "sunny01.mov");
movie.loop();
  
// create the image to show the blobs
blobs = createImage(vidWidth, vidHeight, RGB);  
// initialize blob detection object to the blob image dimensions
theBlobDetection = new BlobDetection(blobs.width, blobs.height);
theBlobDetection.setThreshold(0.8);

 
}

void movieEvent(Movie m) {
  m.read();
}

void draw() {

if(back)background(0);
// copy the image into the smaller blob image
blobs.copy(movie, 0, 0, movie.width, movie.height, 0, 0, blobs.width, blobs.height);
// blur the blob image
blobs.filter(BLUR, blur);
blobs.filter(THRESHOLD);
// detect the blobs
theBlobDetection.computeBlobs(blobs.pixels);
drawBlobsAndEdges(true, true);
//nr Blobs
nrBlobs=theBlobDetection.getBlobNb();

//showing the camera feed
if(cvFeed){  
image(movie, 0, 0, 320, 240);
image(blobs, 0, 245, 320, 250);
}
//printing the framerate
text(frameRate,20,height-20);

}
