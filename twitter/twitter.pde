import twitter4j.*;

Twitter twitter;
String[] tweets = {
  "Test tweet #test",
  "Another test 1 2 3 #test"
};

void setup() {
  size(300,100);
  noLoop();
  textFont(createFont("Helvetica Neue",24));
  
  String[] keys = loadStrings("keys.txt");
  
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
  } catch(Exception e) {
    e.printStackTrace();
  }
  
}

void draw() {
  
}
