# Create a CSV script that would lock funds until one hundred and fifty blocks had passed
# publicKey=02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277
publicKey=02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277
blocks=150

lehex=$(printf '%02x%02x' $((blocks & 0xff)) $(((blocks >> 8) & 0xff)))
push=$(printf '%02x' $((${#lehex} / 2)))

descriptor=$(bitcoin-cli -regtest getdescriptorinfo "pkh($publicKey)" | jq -r '.descriptor')
address=$(bitcoin-cli -regtest deriveaddresses "$descriptor" | jq -r '.[0]')
p2pkh=$(bitcoin-cli -regtest validateaddress "$address" | jq -r '.scriptPubKey')

echo "${push}${lehex}b275${p2pkh}"