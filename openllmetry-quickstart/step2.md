# Step 2: Setup APM and Auto-instrument OpenTelemetry

1. (Optional because you have done in Step 1.) Set the environment variables.

    ```bash
    export OPENAI_API_KEY="sk-0"
    export OPENAI_BASE_URL="https://api.openai-mock.com"
    ```{{exec}}

1. Setup the OTel server. This time is [Jaeger](https://www.jaegertracing.io/). **Execute the command below in a new terminal.**

    ```bash
    docker run --rm --name jaeger \
    -e COLLECTOR_OTLP_GRPC_HOST_PORT=:4317 \
    -p 16686:16686 \
    -p 4317:4317 \
    jaegertracing/all-in-one:1.59
    ```{{exec}}

1. Install the required OpenTelemetry auto-instrumentation tool.

    ```bash
    python -m pip install opentelemetry-distro opentelemetry-exporter-otlp
    .venv/bin/opentelemetry-bootstrap -a install
    ```{{exec}}

1. Execute python script with auto-instrument command.

    ```bash
    .venv/bin/opentelemetry-instrument \
    --traces_exporter console,otlp \
    --exporter_otlp_traces_insecure true \
    --exporter_otlp_traces_protocol grpc \
    --service_name openai-mock-app \
    --exporter_otlp_endpoint localhost:4317 \
    python sample_app/openai_mock_streaming.py
    ```{{exec}}
