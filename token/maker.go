package token

import "time"

// Maker is an interface for managin tokens
type Maker interface {
	// CreateToken creates a new token for specific username and duration
	CreateToken(username string, duration time.Duration) (string, error)

	// VerifyToken checks if token is valid or not
	VerifyToken(token string) (*Payload, error)
}
