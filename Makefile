include .env

install:
	@$(MAKE) -s down
	@$(MAKE) -s docker-build
	@$(MAKE) -s up
	@$(MAKE) -s composer-install

up: docker-up
down: docker-down
ps:
	@docker-compose ps

docker-up:
	@docker-compose -p ${INDEX} up -d

docker-down:
	@docker-compose -p ${INDEX} down --remove-orphans

docker-build: \
	docker-build-app-php-cli \
	docker-build-app-php-fpm \
	docker-build-app-nginx

docker-build-app-nginx:
	@docker build --target=nginx \
	-t ${REGISTRY}/${INDEX}-nginx:${IMAGE_TAG} -f ./docker/Dockerfile .

docker-build-app-php-fpm:
	@docker build --target=fpm \
	-t ${REGISTRY}/${INDEX}-php-fpm:${IMAGE_TAG} -f ./docker/Dockerfile .

docker-build-app-php-cli:
	@docker build --target=cli \
	-t ${REGISTRY}/${INDEX}-php-cli:${IMAGE_TAG} -f ./docker/Dockerfile .

docker-logs:
	@docker-compose -p ${INDEX} logs -f

app-php-cli-exec:
	@docker-compose -p ${INDEX} run --rm php-cli $(cmd)

run-bin:
	$(MAKE) app-php-cli-exec cmd="php ./bin"

composer-install:
	$(MAKE) app-php-cli-exec cmd="composer install"