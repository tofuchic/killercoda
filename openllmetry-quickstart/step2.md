# Step 2: Setup APM and Auto-instrument OpenTelemetry

1. (Optional because you have done in Step 1.) Set the environment variables.

    ```bash
    export OPENAI_API_KEY="sk-0"
    export OPENAI_BASE_URL="https://api.openai-mock.com"
    ```{{exec}}

1. Setup the OTel server. This time is [Jaeger](https://www.jaegertracing.io/). **Execute the command below in the right terminal**.

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

1. Set the environment variable for python logging auto-instrumentation.

    ```bash
    export OTEL_PYTHON_LOGGING_AUTO_INSTRUMENTATION_ENABLED=true
    ```{{exec}}

1. Execute python script with auto-instrument command.

    ```bash
    .venv/bin/opentelemetry-instrument \
    --traces_exporter console,otlp \
    --exporter_otlp_traces_insecure true \
    --exporter_otlp_traces_protocol grpc \
    --service_name openai-mock-app \
    --exporter_otlp_endpoint localhost:4317 \
    python -m flask --app sample_app/openai_mock_streaming.py run -h 0.0.0.0 -p 8080
    ```{{exec}}

1. [Access to the flask app]({{TRAFFIC_HOST1_8080}}).

    - Verify you can get the mock response.

1. [Access to the Jaeger UI]({{TRAFFIC_HOST1_16686}}).

    - Verify you can see the distributed tracing.
