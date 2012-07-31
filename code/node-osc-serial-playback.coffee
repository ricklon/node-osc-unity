#
##
## This plays the log file back and feeds data to Unity3d OSC without the serial data from a live Arduino
#
#
osc = require 'osc-min'
dgram = require "dgram"
fs = require "fs"

udp = dgram.createSocket "udp4"
outport = 10000

# FIlesystem readline
fs.readFile "log.txt", (err, data) ->
  buf = osc.toBuffer(
       address : "/ardcontroller"
       args : [
           data
        ]
    )
  udp.send buf, 0, buf.length, outport, "localhost"    
  console.log "Count: " + count++ + " Data: " + buf
  throw err  if err
