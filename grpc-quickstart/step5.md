# Step 5: Auto-generate files from `.proto`{{}}.

1. Execute `protoc`{{}} command.

    ```bash
    protoc -I. --go_out=. --go-grpc_out=. ./helloworld/helloworld.proto
    ```{{exec}}
