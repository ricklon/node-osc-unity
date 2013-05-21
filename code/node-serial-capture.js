/*
*
* Capture Serial Data to a log file for event replay.
*
*/

  var SerialPort, fs, serialport, sp, sys, tty;
  serialport = require("serialport");
  sys = require("sys");
  fs = require("fs");
  SerialPort = serialport.SerialPort;

  tty = "/dev/tty.usbserial-A1009UMS";

  sp = new SerialPort(tty, {
    parser: serialport.parsers.readline("\n"),
    baudrate: 57600
  });

  sp.on("data", function(data) {
    var encoding;
    fs.appendFileSync("log.txt", data, encoding = "utf8", function(err) {
      if (err) {
        throw err;
      }
    });
    return console.log(data);
  });

  sp.on("error", function(error) {
    return console.log("Error: " + error);
  });
