# Step 4: Modify the proto file

1. To import the local `*.pb.go`{{}} in the server and client codes, init the current repository as the go project.

    ```bash
    go mod init helloworld
    go mod tidy
    ```{{exec}}

1. Copy the source code below and overwrite the `grpc-go/examples/helloworld/helloworld/helloworld.proto`. In theia, you can press "Ctrl + p" for the shortcut and paste the path.

    ```
    syntax = "proto3";

    option go_package = "helloworld/";
    option java_multiple_files = true;
    option java_package = "io.grpc.examples.helloworld";
    option java_outer_classname = "HelloWorldProto";

    package helloworld;

    // The greeting service definition.
    service Greeter {
    // Sends a greeting
    rpc SayHello (HelloRequest) returns (HelloReply) {}
    }

    // The request message containing the user's name.
    message HelloRequest {
    string name = 1;
    string date = 2;
    }

    // The response message containing the greetings
    message HelloReply {
    string message = 1;
    string name = 2;
    }
    ```{{copy}}

    - Client will add a timestamp in a request, and the server will return a message and the server's name.
