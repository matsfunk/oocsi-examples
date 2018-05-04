import nl.tue.id.oocsi.*;

// ******************************************************
// This example requires a running OOCSI server with web
// service support; it will NOT work with the LocalServer
// example provided with the Processing library
//
// ----> https://github.com/iddi/oocsi-web 
//
// ******************************************************


float a, b, c, d;

OOCSI oocsi;

String SERVER_ADDRESS = "your server address";

void setup() {
  size(800, 800);
  noStroke();

  // connect to OOCSI server running on the same machine (localhost)
  // with "voting-example" to be my channel others can send data to
  // (for more information how to run an OOCSI server refer to: https://iddi.github.io/oocsi/)
  //
  // It is CRUCIAL to use the OOCSI server with Web service support that
  // can be found here: https://github.com/iddi/oocsi-web

  oocsi = new OOCSI(this, "voting-example", SERVER_ADDRESS);

  // subscribe to channel "votechannel" to receive votes
  oocsi.subscribe("votechannel");

  // after connecting, you can access the web page at: 
  // http://<SERVER_ADDRESS>/voting-example/index.html
}

void draw() {
  background(255);
  rectMode(CORNER);
  textSize(18);
  float sum = a + b + c + d + .1; 

  pushMatrix();
  translate(40, 20);
  fill(250, 120, 120);
  if (frameCount/120 % 2 == 0)
    text("more of group1", 0, 20);
  else
    text("description", 0, 20);
  rect(0, 50, width/8, map(a, 0, sum, 0, height/2));

  translate(20 + width/5, 0);
  fill(200, 120, 220);
  if (frameCount/120 % 2 == 0)
    text("more of group2", 0, 20);
  else
    text("group description", 0, 20);
  rect(0, 50, width/8, map(b, 0, sum, 0, height/2));

  translate(20 + width/5, 0);
  fill(40, 220, 120);
  if (frameCount/120 % 2 == 0)
    text("more of group2", 0, 20);
  else
    text("group description", 0, 20);
  rect(0, 50, width/8, map(c, 0, sum, 0, height/2));

  translate(20 + width/5, 0);
  fill(220, 220, 120);
  if (frameCount/120 % 2 == 0)
    text("more of group4", 0, 20);
  else
    text("description", 0, 20);
  rect(0, 50, width/8, map(d, 0, sum, 0, height/2));
  popMatrix();

  a *= 0.995;
  b *= 0.995;
  c *= 0.995;
  d *= 0.995;

  // url
  fill(30, 30, 50);
  textSize(25);
  text("http://" + SERVER_ADDRESS + "/voting-example/vote", 120, height-60);

  // progress bar
  pushMatrix();
  rectMode(CENTER);
  translate(map(frameCount, 0, 60 * 60 * 10, 120, width-120), height/2 - 140 -abs(sin(frameCount/20.)) * 40);
  rotate(radians(frameCount*2));
  rect(0, 0, 50, 50);

  popMatrix();
}

// collect the votes coming in via vote channel
void votechannel(OOCSIEvent event) {

  // collect votes in this event (either there is a vote present or we add the default value 0)
  a += event.getInt("a", 0)/10.;
  b += event.getInt("b", 0)/10.;
  c += event.getInt("c", 0)/10.;
  d += event.getInt("d", 0)/10.;

  // print vote count for good measure
  println(a + b + c + d + 1);
}

// serve the HTML page
void handleOOCSIEvent(OOCSIEvent event) {
  StringBuffer sb = new StringBuffer();

  // load HTML file
  String[] ss = loadStrings("vote.html");
  for (String s : ss) {
    sb.append(s + '\n');
  }

  // send out HTML
  oocsi.channel(event.getSender()).data("html", sb.toString()).send();
}