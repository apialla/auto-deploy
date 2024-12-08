# cnet means custom network which should be similar
# to what is specified in compose file for etcd container
qa_network := saqal_network_qa

init:
	@if [ -z "$$(docker network ls --filter name=${qa_network} -q)" ]; then \
		echo "Creating Docker network '${qa_network}'..."; \
		docker network create ${qa_network}; \
	else \
		echo "Docker network '${qa_network}' already exists."; \
	fi

new-dashbaord:
	docker run -it -d --rm --name dashboard.apisix.saqal.qa \
  -p 29000:9000 \
  --network ${qa_network} \
  -v ./apisix_dashboard/config.yaml:/usr/local/apisix-dashboard/conf/conf.yaml \
  apache/apisix-dashboard:latest

dashbaord:
	docker stop dashboard.apisix.saqal.qa
	docker run -it -d --name dashboard.apisix.saqal.qa \
  -p 29000:9000 \
  --network ${qa_network} \
  -v ./apisix-qa/apisix_dashboard/config.yaml:/usr/local/apisix-dashboard/conf/conf.yaml \
  apache/apisix-dashboard:latest
