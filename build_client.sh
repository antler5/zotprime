DOCKER_BUILDKIT=1 docker build --progress=plain --file client.Dockerfile       --build-arg HOST_DS=http://192.168.0.190:8080/       --build-arg HOST_ST=ws://192.168.0.190:8081/       --build-arg MLW=l --output build .