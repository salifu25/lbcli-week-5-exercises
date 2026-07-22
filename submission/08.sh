# Create a time-based CSV script that would lock funds for 6 months (using 30-day months)
# Time-based CSV uses 512-second units with the type flag (bit 22) set
# publicKey=02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277
publicKey=02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277
seconds=$((180*24*3600))
units=$((seconds/512))
value=$((units | (1<<22)))
btcc $value OP_CHECKSEQUENCEVERIFY OP_DROP $publicKey OP_CHECKSIG