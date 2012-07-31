serialport = require("serialport")
SerialPort = serialport.SerialPort # localize object constructor
sys = require("sys")
count = 0

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
  console.log "Count: " + count++ + " Data: " + data

sp.on "error", (error) ->
  console.log "Error: " + error

