#
##
## Capture Serial Data to a log file for event replay.
#
#

serialport = require("serialport")
sys = require("sys")
fs = require("fs");

SerialPort = serialport.SerialPort # localize object constructor

#var tty = "/dev/tty.usbserial-A6003SFW";
#tty = "/dev/tty.usbmodemfa141"
tty = "/dev/tty.usbserial-A1009UMS"

# /dev/tty.usbmodemfa141 
sp = new SerialPort(tty,
  parser: serialport.parsers.readline("\n")
  baudrate: 57600
)

#This line is asynchronous
sp.on "data", (data) ->
   fs.appendFileSync "log.txt", data, encoding = "utf8", (err) ->
        throw err  if err 
   console.log data

sp.on "error", (error) ->
  console.log "Error: " + error


