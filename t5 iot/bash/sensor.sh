#!/bin/bash
# /etc/rc.d/init.d/
 
# Source function library
#. /etc/init.d/functions
 
COUNTING=true
 
start() {
	echo "Publishing in mosquitto test server"
 
        COUNTER=0
        #Get current datetime put it in a variable
        ##CURRENTDATETIME="$(date +'%d/%m/%Y-%T')"
        #Publish in mosquitto server (must be running in the svr and TCP 1883 port opened)
        ##mosquitto_pub -h localhost -m "$COUNTER-$CURRENTDATETIME" -t sensor1
        while [ COUNTING ]
        do
			sleep 1
			COUNTER=$[$COUNTER + 1]
			CURRENTDATETIME="$(date +'%d/%m/%Y-%T')"
			#funcao que le o sensor
			CURRENTTEMP="22.7"
			mosquitto_pub -h localhost -m "$COUNTER  $CURRENTDATETIME  $CURRENTTEMP" -t sensor1sala
        done
        return
}
 
stop() {
        echo -n "Shutting down : "
		echo "Stopping mosquitto test pushish messages"
        COUNTING=false
        return
}
 
case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    status)
        ;;
    restart)
	echo "Restarting mosquitto test pushish messages"
        COUNTING=true
        ;;
    *)
        echo "Usage:  {start|stop|status|reload|restart[|probe]"
        exit 1
        ;;
esac
exit $?
