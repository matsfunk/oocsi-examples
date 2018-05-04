# Webpage example

## what?
This example shows how to use OOCSI to host and serve a very simple HTML file from a Processing client. This helps if you want to work with OOCSI for web (using websockets) and you just need to host a single HTML file that you open on a mobile device or else.

## how?
What happens is that your desktop or mobile broser tries to open the webpage and sends a reques to the OOCSI server such as "http://<>SERVER ADDRESS/simple-webserver/index.html". The OOCSI server will then check if it sees a connected client called "simple-webserver" and send a message to this client. The client responds with web page "index.html" and the OOCSI server delivers it to the browser. Nice. 😎
