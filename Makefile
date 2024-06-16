postgres:
	docker run -p 5432:5432 --name postgres-latest -e POSTGRES_USER=root -e POSTGRES_PASSWORD=mysecret -d postgres

createdb: 
	docker exec -it postgres-latest createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres-latest dropdb simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:mysecret@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:mysecret@localhost:5432/simple_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

.PHONY: postgres createdb dropdb migrateup migratedown sqlc