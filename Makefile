export GO111MODULE=on

all: bin/benchmarker bin/benchmark-worker bin/payment bin/shipment

.PHONY: init-sql
init-sql:
	docker exec -it isu9q-db sh -c 'mysql -uroot -ppassword < /app-data/00_create_database.sql; /app-data/init.sh'

.PHONY: bench
bench:
	docker exec -it isu9q-bench /app/bin/bench -payment-port 5555 -shipment-port 7000 -payment-url http://bench:5555 -shipment-url http://bench:7000 -target-host go -target-url http://go:8000

bin/benchmarker: cmd/bench/main.go bench/**/*.go
	go build -o bin/benchmarker cmd/bench/main.go

bin/benchmark-worker: cmd/bench-worker/main.go
	go build -o bin/benchmark-worker cmd/bench-worker/main.go

bin/payment: cmd/payment/main.go bench/server/*.go
	go build -o bin/payment cmd/payment/main.go

bin/shipment: cmd/shipment/main.go bench/server/*.go
	go build -o bin/shipment cmd/shipment/main.go

vet:
	go vet ./...

errcheck:
	errcheck ./...

staticcheck:
	staticcheck -checks="all,-ST1000" ./...

clean:
	rm -rf bin/*
