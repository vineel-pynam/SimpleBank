postgres:
	docker run -p 5432:5432  --network bank-network  --name postgres-latest -e POSTGRES_USER=root -e POSTGRES_PASSWORD=mysecret -d postgres

createdb: 
	docker exec -it postgres-latest createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres-latest dropdb simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:mysecret@localhost:5432/simple_bank?sslmode=disable" -verbose up

migrateup1:
	migrate -path db/migration -database "postgresql://root:mysecret@localhost:5432/simple_bank?sslmode=disable" -verbose up 1

migratedown:
	migrate -path db/migration -database "postgresql://root:mysecret@localhost:5432/simple_bank?sslmode=disable" -verbose down

migratedown1:
	migrate -path db/migration -database "postgresql://root:mysecret@localhost:5432/simple_bank?sslmode=disable" -verbose down 1

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go

mock:
	mockgen -build_flags=--mod=mod -package mockdb -destination db/mock/store.go github.com/vineel-pynam/SimpleBank/db/sqlc Store

.PHONY: postgres createdb dropdb migrateup migrateup1 migratedown migratedown1 sqlc test server mock