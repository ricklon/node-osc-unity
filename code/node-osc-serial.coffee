#
##
##
#
#
osc = require 'osc-min'
dgram = require "dgram"

udp = dgram.createSocket "udp4"

serialport = require("serialport")
sys = require("sys")

SerialPort = serialport.SerialPort # localize object constructor

outport = 10000
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
    buf = osc.toBuffer(
        address : "/ardcontroller"
        args : [
            data
        ]
    )
    udp.send buf, 0, buf.length, outport, "localhost"    
    console.log "Count: " + count++ + " Data: " + buf

sp.on "error", (error) ->
  console.log "Error: " + error


