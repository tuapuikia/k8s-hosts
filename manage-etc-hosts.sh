#!/bin/bash

# run:
# ./manage-etc-hosts.sh add 10.20.1.2 test.com
# ./manage-etc-hosts.sh remove 10.20.1.2 test.com

# PATH TO YOUR HOSTS FILE
ETC_HOSTS=/k8s/etc/hosts


function remove() {
    # IP to add/remove.
    IP=$1
    # Hostname to add/remove.
    HOSTNAME=$2
    HOSTS_LINE="$IP[[:space:]]$HOSTNAME"
    if [ -n "$(grep -P $HOSTS_LINE $ETC_HOSTS)" ]
    then
        echo "$HOSTS_LINE Found in your $ETC_HOSTS, Removing now...";
        sed -i "/$HOSTS_LINE/d" $ETC_HOSTS
        sleep infinity
    else
        echo "$HOSTS_LINE was not found in your $ETC_HOSTS";
        sleep infinity
    fi
}

function add() {
    IP=$1
    HOSTNAME=$2
    HOSTS_LINE="$IP[[:space:]]$HOSTNAME"
    line_content=$( printf "%s\t%s\n" "$IP" "$HOSTNAME" )
    if [ -n "$(grep -P $HOSTS_LINE $ETC_HOSTS)" ]
        then
            echo "$line_content already exists : $(grep $HOSTNAME $ETC_HOSTS)"
        else
            echo "Adding $line_content to your $ETC_HOSTS";
            sh -c -e "echo '$line_content' >> $ETC_HOSTS";

            if [ -n "$(grep -P $HOSTNAME $ETC_HOSTS)" ]
                then
                    echo "$line_content was added succesfully";
                    sleep infinity
                else
                    echo "Failed to Add $line_content, Try again!";
                    exit 1
            fi
    fi
}

function help() {
    echo '
    To add new host 
    please use /usr/local/sbin/manage-etc-hosts.sh add 10.20.1.2 test.com
    To remove host
    please use /usr/local/sbin/manage-etc-hosts.sh add 10.20.1.2 test.com
    '
}

$@
