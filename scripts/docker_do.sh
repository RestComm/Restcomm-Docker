#!/bin/bash

stop_container () {
  echo -en "\e[92mstop container $1\e[0m\n"
  docker stop $1
}

start_container () {
  echo -en "\e[92mstart container $1\e[0m\n"
  docker start $1
}

run_container () {
   echo -en "\e[92mrun container\e[0m\n"
   echo "need to be done"
}

pull_container () {
 echo -en "\e[92mpull container $1\e[0m\n"
 docker pull $1
}

info_container () {
  docker ps;
}


collect_logs () {
echo -en "\e[92mpull collect logs container $1\e[0m\n"
time_logs=""
if $tflag ; then
 time_logs="-t $time_marg"
fi

echo $time_marg
docker exec $1  /bin/sh -c "/opt/embed/logs_collect.sh $time_logs"
}


collect_logs_time () {
echo -en "\e[92mpull collect logs by time for container $1\e[0m\n"
docker exec $1  /bin/sh -c "/opt/embed/logs_collect.sh $2"
}

docker_login() {
 docker login
}

delete_container () {
read -p "Are you sure about deleting container $1? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo -en "\e[92mdelete container $1\e[0m\n"
    docker rm $1
else
    echo "container no deleted"
    exit 1
fi
}

usage () {
   cat << EOF
Usage: docker_do.sh  <options>

options:
-s : stop container (-c obligatory).
-S : start container (-c obligatory).
-r : run new container (-H obligatory). Optional (-n).
-H : Host name (only with -r)
-n : Container name (only with -r), if not used default name "telscale-restcomm"
-l : collect logs (-c obligatory).
-t : collect logs by time (-l obligatory) e.g. "21:03:0*,22:00:0*".
-i : running containers.
-p : pull from hub (-L obligatory).
-L : login to docker hub.
-c : container to use.
-d : delete container.
-h : prints this message
EOF
   exit 1
}

#MAIN
sflag=false
Sflag=false
rflag=false
lflag=false
cflag=false
pflag=false
iflag=false
Lflag=false
iflag=false
dflag=false
tflag=false
Hflag=false
nflag=false
login=false


#Global variables
 container_name="telscale-restcomm"

if [ $# -eq 0 ];
then
    usage
    exit 0
else

while getopts ":rH:n:sSp:c:ilLdht:" opt; do
  case $opt in
        s )
           sflag=true
        ;;
        S )
           Sflag=true
        ;;
	H )
	   Hflag=true
           host=$OPTARG
        ;;
	n )
	   nflag=true
          container_name=$OPTARG
        ;;
        r )
           rflag=true
        ;;
        l )
           lflag=true
        ;;
        c )
           cflag=true
           container=$OPTARG
        ;;
        p )
           pflag=true
           pull_repo=$OPTARG
        ;;
        t )
           tflag=true
           time_marg=$OPTARG
        ;;
        i )
           iflag=true
        ;;
        L )
           Lflag=true
        ;;

        d )
           dflag=true
        ;;
        h )
           usage
        ;;
        \?)
          echo "Invalid option: -$OPTARG" >&2
          exit 1
        ;;
         :)
          if ("$opt" = "p"); then
             pull_repo="restcomm/restcomm:latest"
             read -p "Default hub repo $pull_repo  will be used OK?" -n 1 -r
             echo    # move to a new line
                if [[ $REPLY =~ ^[Yy]$ ]]
                then
                        pflag=true
                        continue
                else
                        echo
                fi
          fi
          echo "Option -$OPTARG requires an argument." >&2
          exit 1
        ;;
    esac
done;


if [[ ("$sflag" = "true" || "$Sflag" = "true" || "$lflag" = "true" || "$dflag" = "true")  &&  "$cflag" = "false" ]]; then
    echo " For flags (-s, -S, -l, -d)  a container must  be specified  (-c) " >&2
    exit 1
fi

if [[ "$tflag" = "true"  &&  "$lflag" = "false" ]]; then
    echo " For flag -t  flag -l  must  be specified " >&2
    exit 1
fi

if [[ "$rflag" = "true"  &&  "$Hflag" = "false" ]]; then
    echo " To run a container Hostname is necessary (flag -H) " >&2
    exit 1
fi

if $lflag ; then
 collect_logs $container
fi


if $sflag ; then
 stop_container $container
fi

if $Lflag ; then
    login=true
    docker_login
fi

if $pflag ; then
   if ! $login ; then
    echo -en  "\e[31mMake sure you are connected to docker hub (-L)\e[0m\n"
   fi
    pull_container $pull_repo
fi

if $dflag ; then
    delete_container $container
fi

if $Sflag ; then
    start_container $container
fi

if $rflag ; then
    run_container $host
fi

if $iflag ; then
    info_container
fi

fi