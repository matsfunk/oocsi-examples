import nl.tue.id.oocsi.*;

// ******************************************************
// This example requires a running OOCSI server with web
// service support; it will NOT work with the LocalServer
// example provided with the Processing library
//
// ----> https://github.com/iddi/oocsi-web 
//
// ******************************************************

OOCSI oocsi;

void setup() {
  size(200, 200);

  // connect to OOCSI server running on the same machine (localhost)
  // with "simple-webserver" to be my channel others can send data to
  // (for more information how to run an OOCSI server refer to: https://iddi.github.io/oocsi/)
  //
  // It is CRUCIAL to use the OOCSI server with Web service support that
  // can be found here: https://github.com/iddi/oocsi-web

  oocsi = new OOCSI(this, "simple-webserver", "<SERVER ADDRESS>");

  // after connecting, you can access the web page at: 
  // http://<SERVER ADDRESS>/simple-webserver/index.html
}

void draw() {
  // do nothing
}

void handleOOCSIEvent(OOCSIEvent event) {
  StringBuffer sb = new StringBuffer();

  // load HTML file
  String[] ss = loadStrings("index.html");
  for (String s : ss) {
    sb.append(s + '\n');
  }

  // get HTML
  oocsi.channel(event.getSender()).data("html", sb.toString()).send();
}