docker stop metro
docker rm metro
docker rmi metro
docker build -t metro  .
docker run -p 9876:9876 --name metro -d metro

