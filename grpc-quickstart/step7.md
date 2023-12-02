# Step 7: Update the server application.

1. Copy the source code below and override the `greeter_server/main.go`{{}}.

    ```
    // Package main implements a server for Greeter service.
    package main
    
    import (
    	"context"
    	"flag"
    	"fmt"
    	"log"
    	"net"
    
    	"google.golang.org/grpc"
    	"helloworld/helloworld"
    )

    const (
    	serverName = "Tofu"
    )
    
    var (
    	port = flag.Int("port", 50051, "The server port")
    )
    
    // server is used to implement helloworld.GreeterServer.
    type server struct {
    	helloworld.UnimplementedGreeterServer
    }
    
    // SayHello implements helloworld.GreeterServer
    func (s *server) SayHello(ctx context.Context, in *helloworld.HelloRequest) (*helloworld.HelloReply, error) {
    	log.Printf("Received: %v", in.GetName())
    	return &helloworld.HelloReply{Message: "Hello " + in.GetName(),Name: serverName}, nil
    }
    
    func main() {
    	flag.Parse()
    	lis, err := net.Listen("tcp", fmt.Sprintf(":%d", *port))
    	if err != nil {
    		log.Fatalf("failed to listen: %v", err)
    	}
    	s := grpc.NewServer()
    	helloworld.RegisterGreeterServer(s, &server{})
    	log.Printf("server listening at %v", lis.Addr())
    	if err := s.Serve(lis); err != nil {
    		log.Fatalf("failed to serve: %v", err)
    	}
    }
    ```{{copy}}

1. In the LEFT tab, stop the server with `Ctrl + c`{{}}.  

1. Execute the NEW server application.

    ```bash
    go run greeter_server/main.go
    ```{{exec}}

1. In the RIGHT tab, execute the client application and send a request.

    ```bash
    go run greeter_client/main.go
    ```{{exec}}
