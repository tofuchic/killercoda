# Step 4: Use Instana instead of Jaeger

1. Stop the Jaeger. **Execute the command below in the right terminal**.

    ```bash
    echo stop jaeger
    ```{{exec interrupt}}

1. Check your Instana `agent key` and `download key` in your Instana tenant.

    ```bash
    INSTANA_AGENT_KEY=
    ```{{copy}}

    ```bash
    INSTANA_DOWNLOAD_KEY=
    ```{{copy}}

1. Install the Instana agent.

    ```bash
    curl -o setup_agent.sh https://setup.instana.io/agent && chmod 700 ./setup_agent.sh && sudo ./setup_agent.sh -a $INSTANA_AGENT_KEY -d $INSTANA_DOWNLOAD_KEY -t dynamic -e ingress-coral-saas.instana.io:443 -y -s
    ```{{exec}}

1. Enable gRPC and restart the Instana agent.

    ```bash
    cat <<EOF >> /opt/instana/agent/etc/instana/configuration.yaml
    com.instana.plugin.opentelemetry:
        grpc: enabled: true
    EOF
    systemctl restart instana-agent.service
    ```{{exec}}

1. (Optional because you have done in previous steps.) Set the environment variables.

    ```bash
    export OPENAI_API_KEY="sk-0"
    export OPENAI_BASE_URL="https://api.openai-mock.com"
    export TRACELOOP_BASE_URL="localhost:4317"
    ```{{exec}}

1. Set the environment variables to authenticate the Instana agent.

    ```bash
    TRACELOOP_HEADERS="Authorization=Api-Token%20$INSTANA_AGENT_KEY"
    ```{{exec}}

1. Execute python script with auto-instrument command.

    ```bash
    .venv/bin/opentelemetry-instrument \
    --traces_exporter console,otlp \
    --logs_exporter console,otlp \
    --metrics_exporter console,otlp \
    --service_name openai-mock-app \
    --exporter_otlp_logs_protocol grpc \
    --exporter_otlp_endpoint localhost:4317 \
    --exporter_otlp_traces_insecure true \
    --exporter_otlp_logs_insecure true \
    --exporter_otlp_metrics_insecure true \
    python -m flask --app sample_app/openai_mock_streaming_openllmetry.py run -h 0.0.0.0 -p 8080
    ```{{exec}}

1. [Access to the flask app]({{TRAFFIC_HOST1_8080}}).

    - Verify you can get the mock response.

1. Access to the Instana.

    - Verify you can see the distributed tracing, and they includes the LLM specific infomation.
