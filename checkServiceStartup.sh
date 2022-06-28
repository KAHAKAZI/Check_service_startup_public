#!/bin/bash

TIME=$($1)
URL_ADDRESS=$2
SUCCESS_MSG="Service started succesfully - HTTP "
CLIENT_ERROR_MSG="Service responds with an error - HTTP "
SERVER_ERR_MSG="Service responds with an error - HTTP "
PENDING_MSG="Waiting for a responnse [s] "
OTHER_MSG="Other responnse - HTTP "
OUT_TIME_MSG="Serice did not respond in given time"

echo "$INIT_MSG" $TIME

while [ "$TIME" != 0 ]; do
        STATUS=$(curl -m 1 -I -L -s -w "%{http_code}\n" $URL_ADDRESS | tail -1)

        if [ "$STATUS" -eq "200" ]; then
                echo "$SUCCESS_MSG" $STATUS
                exit 0
        elif [[ $STATUS =~ ^"50" ]]; then
                echo "$SERVER_ERR_MSG" $STATUS
                exit 1
        elif [[ $STATUS =~ ^"40" ]]; then
                echo "$CLIENT_ERROR_MSG" $STATUS
                exit 1
        elif [[ $STATUS == "000" ]]; then
                echo "$PENDING_MSG" $1 "..."
        else
                echo "$OTHER_MSG" $STATUS
                exit 1
        fi

        sleep 1
        TIME=$(($TIME - 1))
done

echo "$OUT_TIME_MSG"
exit 1
