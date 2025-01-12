package gapi

import (
	"fmt"

	db "github.com/vineel-pynam/SimpleBank/db/sqlc"
	"github.com/vineel-pynam/SimpleBank/pb"
	"github.com/vineel-pynam/SimpleBank/token"
	"github.com/vineel-pynam/SimpleBank/utils"
	"github.com/vineel-pynam/SimpleBank/worker"
)

// Server serves all gRPC requests for our banking service.
type Server struct {
	pb.UnimplementedSimpleBankServer
	config          utils.Config
	tokenMaker      token.Maker
	store           db.Store
	taskDistributor worker.TaskDistributor
}

func NewServer(config utils.Config, store db.Store, taskDistributor worker.TaskDistributor) (*Server, error) {
	tokenMaker, err := token.NewPasetoMaker(config.TokenSymmetricKey)
	if err != nil {
		return nil, fmt.Errorf("cannot create token maker: %w", err)
	}

	server := &Server{
		config:          config,
		store:           store,
		tokenMaker:      tokenMaker,
		taskDistributor: taskDistributor,
	}

	return server, nil
}
