#!/bin/bash
# /etc/rc.d/init.d/
 
# Source function library
#. /etc/init.d/functions
 
COUNTING=true

sede() {
	echo "Publishing in mosquitto test server"
 
        COUNTER=0
        #Get current datetime put it in a variable
        ##CURRENTDATETIME="$(date +'%d/%m/%Y-%T')"
        #Publish in mosquitto server (must be running in the svr and TCP 1883 port opened)
        ##mosquitto_pub -h localhost -m "$COUNTER-$CURRENTDATETIME" -t sensor1
        while [ COUNTING ]
        do
			COUNTER=$[$COUNTER + 1]
			CURRENTDATETIME="$(date +'%d/%m/%Y-%T')"
			CURRENTSTATUS="VERDE"
			mosquitto_pub -h localhost -m "  $CURRENTDATETIME  $CURRENTSTATUS" -t sinal-sede
			sleep 5

			CURRENTDATETIME="$(date +'%d/%m/%Y-%T')"
			CURRENTSTATUS="LARANJA"
			mosquitto_pub -h localhost -m "  $CURRENTDATETIME  $CURRENTSTATUS" -t sinal-sede
			sleep 2

			CURRENTDATETIME="$(date +'%d/%m/%Y-%T')"
			CURRENTSTATUS="VERMELHO"
			mosquitto_pub -h localhost -m "  $CURRENTDATETIME  $CURRENTSTATUS" -t sinal-sede
			sleep 5

        done
        return
}


posto() {
	echo "Publishing in mosquitto test server"
 
        COUNTER=0
        while [ COUNTING ]
        do
			COUNTER=$[$COUNTER + 1]
			CURRENTDATETIME="$(date +'%d/%m/%Y-%T')"
			CURRENTSTATUS="VERDE"
			mosquitto_pub -h localhost -m "  $CURRENTDATETIME  $CURRENTSTATUS" -t sinal-postoganso
			sleep 5

			CURRENTDATETIME="$(date +'%d/%m/%Y-%T')"
			CURRENTSTATUS="LARANJA"
			mosquitto_pub -h localhost -m "  $CURRENTDATETIME  $CURRENTSTATUS" -t sinal-postoganso
			sleep 2

			CURRENTDATETIME="$(date +'%d/%m/%Y-%T')"
			CURRENTSTATUS="VERMELHO"
			mosquitto_pub -h localhost -m "  $CURRENTDATETIME  $CURRENTSTATUS" -t sinal-postoganso
			sleep 5

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
    sede)
        sede
        ;;
    posto)
        posto
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
