# Step 4: Modify the proto file

1. Open the file `grpc-go/examples/helloworld/helloworld.proto`. You can press "Ctrl + p" for the theia shortcut and paste the path.

1. Modify the `option go_package`{{}} as follows.

    ```
    option go_package = "helloworld/";
    ```

1. Let's add a new attribute to the `HelloReply`{{}} as follows

    ```{4}
    // The response message containing the greetings
    message HelloReply {
      string message = 1;
      string name = 2;
    }
    ```{{exec}}
