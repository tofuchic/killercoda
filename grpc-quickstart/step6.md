# Step 6: Update the client application.

1. Copy the source code below and override the `main.go`.

    ```
    package main
    
    import (
    	"context"
    	"flag"
    	"log"
    	"time"
    
    	"google.golang.org/grpc"
    	"google.golang.org/grpc/credentials/insecure"
    	"helloworld/helloworld"
    )
    
    const (
    	defaultName = "world2"
    )
    
    var (
    	addr = flag.String("addr", "localhost:50051", "the address to connect to")
    	name = flag.String("name", defaultName, "Name to greet")
    )
    
    func main() {
    	flag.Parse()
    	// Set up a connection to the server.
    	conn, err := grpc.Dial(*addr, grpc.WithTransportCredentials(insecure.NewCredentials()))
    	if err != nil {
    		log.Fatalf("did not connect: %v", err)
    	}
    	defer conn.Close()
    	c := helloworld.NewGreeterClient(conn)
    
    	// Contact the server and print out its response.
    	ctx, cancel := context.WithTimeout(context.Background(), time.Second)
    	defer cancel()
    	r, err := c.SayHello(ctx, &helloworld.HelloRequest{Name: *name})
    	if err != nil {
    		log.Fatalf("could not greet: %v", err)
    	}
    	log.Printf("Greeting: %s", r.GetMessage())
    	log.Printf("Server name: %s", r.GetName())
    }
    ```

1. Execute the client application and send a request to THE OLD SERVER.

    ```bash
    go run greeter_client/main.go
    ```{{exec}}
