.PHONY: build enter push push-ci

build:
    docker build -t b00gizm/dev-to-go .

enter:
    docker run -it --rm --name dev-to-go --hostname dev-to-go b00gizm/dev-to-go bash

push:
    docker push b00gizm/dev-to-go

push-ci:
    @echo "$(DOCKER_PASSWORD)" | docker login -u "$(DOCKER_USERNAME)" --password-stdin
    docker push b00gizm/dev-to-go
