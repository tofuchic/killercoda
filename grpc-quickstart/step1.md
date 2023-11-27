In this scenario, you will run the example applications of gRPC.
The example applications code exists in the official gRPC repository, so you first have to clone it.
After you clone the respository, you can run server and client applications respectively.
But before all of this, you must fulfill the prerequisites.

# Step 1

1. Check the Go version is one of the three latest major [releases of Go](https://go.dev/doc/devel/release).

    ```bash
    go version
    ```{{exec}}

1. Install the [Protocol buffer](https://developers.google.com/protocol-buffers) compiler, `protoc`.

    ```bash
    apt install -y protobuf-compiler
    ```{{exec}}

1. Install the Go plugins for the protocol compiler.

    ```bash
    go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.28
    go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.2
    ```{{exec}}

1. Clone the gRPC example repository.

    ```bash
    git clone -b v1.59.0 --depth 1 https://github.com/grpc/grpc-go
    ```{{exec}}

1. Change to the quick start example directory.

    ```bash
    cd grpc-go/examples/helloworld
    ```{{exec}}
