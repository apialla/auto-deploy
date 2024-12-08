# dev_network means custom network which should be similar
# to what is specified in compose file for etcd container
dev_network := saqal_network_dev

init:
	@if [ -z "$$(docker network ls --filter name=${dev_network} -q)" ]; then \
		echo "Creating Docker network '${dev_network}'..."; \
		docker network create ${dev_network}; \
	else \
		echo "Docker network '${dev_network}' already exists."; \
	fi
	docker compose up -d
	make dashbaord

reinit:
	docker compose down -v && make init

dashbaord:
	docker run -it -d --rm --name dashboard.apisix.saqal.dev \
  -p 19000:9000 \
  --network ${dev_network} \
  -v ./apisix_dashboard/config.yaml:/usr/local/apisix-dashboard/conf/conf.yaml \
  apache/apisix-dashboard:latest
