/*
*
* Convert control data from the Arduino into UDP data using OSC
*
*/

  var SerialPort, count, dgram, osc, outport, serialport, sp, sys, tty, udp;
  osc = require("osc-min");
  dgram = require("dgram");
  udp = dgram.createSocket("udp4");
  serialport = require("serialport");
  sys = require("sys");

  SerialPort = serialport.SerialPort;

  outport = 10000;
  count = 0;
  tty = "/dev/tty.usbserial-A1009UMS";

  sp = new SerialPort(tty, {
    parser: serialport.parsers.readline("\n"),
    baudrate: 57600
  });

  sp.on("data", function(data) {
    var buf;
    buf = osc.toBuffer({
      address: "/ardcontroller",
      args: [data]
    });
    udp.send(buf, 0, buf.length, outport, "localhost");
    return console.log("Count: " + count++ + " Data: " + buf);
  });

  sp.on("error", function(error) {
    return console.log("Error: " + error);
  });


