void setup() {
  size(300,390);
  smooth();
  colorMode(HSB); // Hue, Saturation, Brightness
}

int col = 150;
int eye = 512;
int mouth = 1024;

void draw() {
  
  background(255);
  strokeWeight(3);
  
  drawSliders();
  
  // Values from 0 to 1023 to control hue val
  color c = color(map(col, 0, 1024, 0, 255), 255, 255);
  fill(c);
  
  // Face
  ellipse(150,150,250,250);
  
  // Eyes of smiley
  fill(255);
  ellipse(120,140,60,60);
  ellipse(180,140,60,60);
  fill(0);
  ellipse(125,150,20,20);
  ellipse(175,150,20,20);
  
  // Eyebrows
  line(100,100+map(eye,0,1024,-10,10),140,100-map(eye,0,1024,-10,10));
  line(160,100+map(eye,0,1024,-10,10),200,100-map(eye,0,1024,-10,10));
  
  // Mouth
  noFill();
  beginShape();
  curveVertex(100,200);
  curveVertex(100,200);
  curveVertex(150,180+map(mouth,0,1024,0,50));
  curveVertex(200,200);
  curveVertex(200,200);
  endShape();
  
}


void drawSliders() {
 
 fill(0);
 strokeWeight(1);
 
 // Change mouth
 rect(20,315,width-40,2);
 ellipse(15+map(mouth,0,1024,0,width-40),315,15,15);
 
 // Change eyebrow
 rect(20,345,width-40,2);
 ellipse(15+map(eye,0,1024,0,width-40),346,15,15);
 
 // Change color
 rect(20,375,width-40,2);  
 ellipse(15+map(col,0,1024,0,width-40),375,15,15);
}
