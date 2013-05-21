/*
*
*
*
*/  
  var SerialPort, count, serialport, sp, sys, tty;
  serialport = require("serialport");
  SerialPort = serialport.SerialPort;
  sys = require("sys");

  count = 0;
  tty = "/dev/tty.usbserial-A1009UMS";

  sp = new SerialPort(tty, {
    parser: serialport.parsers.readline("\n"),
    baudrate: 57600
  });

  sp.on("data", function(data) {
    return console.log("Count: " + count++ + " Data: " + data);
  });

  sp.on("error", function(error) {
    return console.log("Error: " + error);
  });
