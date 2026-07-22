# Create a time-based CSV script that would lock funds for 6 months (using 30-day months)
# Time-based CSV uses 512-second units with the type flag (bit 22) set
# publicKey=02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277
publicKey=02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277

seconds=$((6 * 30 * 24 * 60 * 60))
units=$((seconds / 512))
value=$((units | (1 << 22)))

lehex=$(printf '%02x%02x%02x' $((value & 0xff)) $(((value >> 8) & 0xff)) $(((value >> 16) & 0xff)))
push=$(printf '%02x' $((${#lehex} / 2)))

descriptor=$(bitcoin-cli -regtest getdescriptorinfo "pkh($publicKey)" | jq -r '.descriptor')
address=$(bitcoin-cli -regtest deriveaddresses "$descriptor" | jq -r '.[0]')
p2pkh=$(bitcoin-cli -regtest validateaddress "$address" | jq -r '.scriptPubKey')

echo "${push}${lehex}b275${p2pkh}"