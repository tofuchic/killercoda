# Step 4: Use Instana

1. Check your Instana `agent key` and `download key` in your Instana tenant.

    ```
    INSTANA_AGENT_KEY=
    ```{{copy}}

    ```

    INSTANA_DOWNLOAD_KEY=
    ```{{copy}}

1. Install the Instana agent.

    ```bash
    curl -o setup_agent.sh https://setup.instana.io/agent && chmod 700 ./setup_agent.sh && sudo ./setup_agent.sh -a $INSTANA_AGENT_KEY -d $INSTANA_DOWNLOAD_KEY -t dynamic -e ingress-coral-saas.instana.io:443 -y -s
    ```{{exec}}

1. Enable gRPC and restart the Instana agent.

    ```
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
