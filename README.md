



### Build

To build the image:
docker build -t restcomm .


### Run

docker run -t -i -p 5080:5080 -p 5080:5080/udp -p 8080:8080 -p 64534-65535:64534-65535/udp --name=restcomm restcomm 


docker run --name=rc -d -p 8080:8080 -p 5080:5080 -p 5080:5080/udp -p 65000-65535/udp restcomm
docker run --name=rc --entrypoint=/bin/sh -it -p 8080:8080 -p 5080:5080 -p 5080:5080/udp restcomm
