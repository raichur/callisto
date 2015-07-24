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

void draw() {
  
}
