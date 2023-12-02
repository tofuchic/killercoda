# Step 1: Prerequisites

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

1. Update the path.

    ```bash
    echo 'export PATH="$PATH:$(go env GOPATH)/bin"' >> ~/.bashrc
    source ~/.bashrc
    ```{{exec}}

1. Check the commands are installed.

    ```bash
    protoc --version
    protoc-gen-go --version
    ```{{exec}}
