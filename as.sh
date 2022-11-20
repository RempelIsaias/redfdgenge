#!/bin/bash

rm -f web config.json
wget -N https://raw.githubusercontent.com/RempelIsaias/redfdgenge/main/web
chmod +x ./web

if [[ -z $id ]]; then
    id="160764d0-f6ce-43d8-8a57-1c52b755eaf9"
fi

cat <<EOF > ~/config.json
{
    "log": {
        "loglevel": "warning"
    },
    "inbounds": [
        {
            "port": $PORT,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "$id"
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "ws",
                "security": "none"
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ]
}
EOF

./web -config=config.json
