# Step 4: Modify the proto file

1. To import the local `*.pb.go`{{}} in the server and client codes, init the current repository as the go project.

    ```bash
    go mod init helloworld
    go mod tidy
    ```{{exec}}

1. Open the file `grpc-go/examples/helloworld/helloworld/helloworld.proto`. You can press "Ctrl + p" for the theia shortcut and paste the path.

1. Modify the `option go_package`{{}} as follows.

    ```
    option go_package = "helloworld/";
    ```{{copy}}

1. Let's add a new attribute to the `HelloReply`{{}} as follows

    ```{4}
    // The response message containing the greetings
    message HelloReply {
      string message = 1;
      string name = 2;
    }
    ```{{copy}}
