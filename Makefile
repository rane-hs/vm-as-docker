.PHONY: clean build start stop ssh

default:
	@echo
	@echo "Usage:"
	@echo "    make [task]"
	@echo
	@echo "Tasks:"
	@echo "    clean               clean all"
	@echo "    build               create docker image"
	@echo "    start               start docker-compose"
	@echo "    stop                stop docker-compose"
	@echo "    ssh                 ssh to local"

clean:
	./local/bin/docker-clean

build:
	docker-compose build

start:
	docker-compose up -d

stop:
	docker-compose stop

terminate:
	docker-compose down
	./local/bin/docker-clean

ssh:
	ssh -A rane@0.0.0.0 -p 10022
