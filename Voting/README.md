# Voting example

## what?
This example shows how to use OOCSI to host and serve a simple HTML file from a Processing client and let this page send data back to OOCSI. This is useful if you want to see how to work with OOCSI for web (using websockets) and you just need to host a single HTML file that you open on a mobile device or else.

## how?
What happens is that your desktop or mobile broser tries to open the webpage and sends a reques to the OOCSI server such as "http://<>SERVER ADDRESS/voting-example/vote.html". The OOCSI server will then check if it sees a connected OOCSI client called "voting-example" and send a message to this client. The client responds with the web page "vote.html" and the OOCSI server delivers it to the browser.

In this particular case, this web page just contains four voting buttons. Behind the scenes, the browser opens a web socket connection to the OOCSI server and when the user clicks on one of the voting buttons, the vote is sent to the OOCSI server on the channel "votechannel". The Processing sketch listens on this channel and will receive the votes, which are visualised in Processing.

Sounds complex? Not really, try it out. 😌
