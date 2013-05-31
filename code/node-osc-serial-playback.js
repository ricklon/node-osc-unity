/*
*
* This plays the log file back and feeds data to Unity3d OSC without the serial data from a live Arduino
*
*/

  var dgram, fs, osc, outport, udp;
  osc = require('osc-min');
  dgram = require("dgram");
  fs = require("fs");
  udp = dgram.createSocket("udp4");

  outport = 10000;

  fs.readFile("playbackdata.json", function(err, data) {
  if (err) {
    throw err;
  }
    var buf;
     buf = osc.toBuffer({
      address: "/ardcontroller",
      args: [data]
    });
  udp.send(buf, 0, buf.length, outport, "localhost");
  console.log("Count: " + count++ + " Data: " + buf);
    return buf;
  });
