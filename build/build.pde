import twitter4j.*;

Twitter twitter;
String[] tweets = {
  "My emotion can be best described as: #Callisto",
  "I feel so: #Callisto"
};

void setup() {
  size(300,480);
  smooth();
  colorMode(HSB); // Hue, Saturation, Brightness
}

int col = 150;
int eye = 512;
int mouth = 1024;
boolean mclick = false; // Mouth Slider
boolean eclick = false; // Eyebrow Slider
boolean cclick = false; // Color Slider
boolean bclick = false; // Button pressed 

void draw() {
  
  background(255);
  strokeWeight(3);
  
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
  
  // Draw stuff on canvas
  drawSliders();
  drawButton();
  initTwitter();
  
}


void drawSliders() {
 
 fill(#E54A3D);
 strokeWeight(3);
 
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

void mousePressed() {
  if(mouseY>310 && mouseY<325) {
    mclick = true;
    mouth = constrain(int(map(mouseX,20,width-20,0,1024)),0,1024);
  }
  if(mouseY>340 && mouseY<355) {
    eclick = true;
    eye = constrain(int(map(mouseX,20,width-20,0,1024)),0,1024);
  }
  if(mouseY>360 && mouseY<390) {
    cclick = true;
    col = constrain(int(map(mouseX,20,width-20,0,1024)),0,1024);
  }
  if(mouseY>height-80 && mouseY<height-30 && mouseX>20 && mouseX<width-20) {
    bclick = true;
    return;
  }
}

void mouseDragged() {
  if(mclick) mouth = constrain(int(map(mouseX,20,width-20,0,1024)),0,1024);
  if(eclick) eye = constrain(int(map(mouseX,20,width-20,0,1024)),0,1024);
  if(cclick) col = constrain(int(map(mouseX,20,width-20,0,1024)),0,1024);
}

void mouseReleased() {
  if(bclick) {
    tweet();
  }
  bclick = false;
  mclick = false;
  eclick = false;
  cclick = false;
}

// Tweet button
void drawButton() {
  fill(bclick ? 128 : 255);
  stroke(0);
  strokeWeight(2);
  rect(20,height-80,width-40,50);
  fill(0);
  textSize(30);
  text("TWEET",105,height-44);
}


// Initializing Twitter
void initTwitter() {
 
 String[] keys = loadStrings("keys.txt");
 
 if(keys.length <= 2) {
    try {
      twitter = TwitterFactory.getSingleton();
      twitter.setOAuthConsumer(keys[0],keys[1]);
      RequestToken requestToken = twitter.getOAuthRequestToken();
      AccessToken at = null;
      if(System.getProperty("os.name").toLowerCase().indexOf("win")>=0) {
        link(requestToken.getAuthorizationURL());
      } else {
        open(requestToken.getAuthorizationURL());
      }
      
      String preset = "";
      String pin = javax.swing.JOptionPane.showInputDialog(frame,"Enter your PIN here",preset);
      at = twitter.getOAuthAccessToken(requestToken,pin);
      
      String[] newKeys = new String[4];
      newKeys[0] = keys[0];
      newKeys[1] = keys[1];
      newKeys[2] = at.getToken();
      newKeys[3] = at.getTokenSecret();
      
      saveStrings("data/keys.txt",newKeys);
      
    } catch(Exception e) {
      e.printStackTrace();
    }
  } else {
    ConfigurationBuilder cb = new ConfigurationBuilder();
    cb.setOAuthConsumerKey(keys[0]);
    cb.setOAuthConsumerSecret(keys[1]);
    cb.setOAuthAccessToken(keys[2]);
    cb.setOAuthAccessTokenSecret(keys[3]);
    
    twitter = new TwitterFactory(cb.build()).getInstance();
  }
  
}


// Tweet with Image
void tweet() {
  
  PImage image = get(0,0,300,300);
  image.save("emoticon.png");
  
  java.io.File f = new java.io.File(sketchPath("emoticon.png"));
  StatusUpdate status = new StatusUpdate(tweets[int(random(tweets.length))]);
  status.setMedia(f);
  try {
    twitter.updateStatus(status);
  } catch (Exception e) {
    e.printStackTrace();
  }
}
