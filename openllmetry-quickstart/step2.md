# Step 2: Instrument OpenTelemetry

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
    --service_name openai-mock-app \
    --exporter_otlp_logs_protocol grpc \
    --exporter_otlp_endpoint localhost:4317 \
    --exporter_otlp_traces_insecure true \
    python sample_app/openai_mock_streaming.py
    ```{{exec}}

---

1. Create the script which will call [openai-mock](https://api.openai-mock.com/#introduction) and send the trace to the APM.

    ```bash
    touch sample_app/openai_mock_streaming_otel.py
    ```{{exec}}

1. Copy and paste the code below to the file you have created.

    ```
    import os
    from openai import OpenAI
    from traceloop.sdk import Traceloop
    from traceloop.sdk.decorators import workflow

    Traceloop.init(disable_batch=True)

    client = OpenAI(
        api_key=os.environ["OPENAI_API_KEY"],
        base_url=os.environ["OPENAI_BASE_URL"],
    )

    @workflow(name="create_joke")
    def create_joke():
        completion = client.chat.completions.create(
            model="gpt-3.5-turbo",
            messages=[{"role": "user", "content": "<<short>>Tell me a joke about opentelemetry"}],
        )

        return completion.choices[0].message.content

    @workflow(name="translate_joke_to_pirate")
    def translate_joke_to_pirate(joke: str):
        completion = client.chat.completions.create(
            model="gpt-3.5-turbo",
            messages=[{"role": "user", "content": f"<<medium>>Translate the below joke to pirate-like english:\n\n{joke}"}],
        )

        history_jokes_tool()

        return completion.choices[0].message.content

    @workflow(name="history_jokes_tool")
    def history_jokes_tool():
        completion = client.chat.completions.create(
            model="gpt-3.5-turbo",
            messages=[{"role": "user", "content": f"<<long>>get some history jokes"}],
        )

        return completion.choices[0].message.content

    @workflow(name="joke_workflow")
    def joke_workflow():
        eng_joke = create_joke()
        pirate_joke = translate_joke_to_pirate(eng_joke)
        print(pirate_joke)
        
    if __name__ == "__main__":
        joke_workflow()
    ```{{copy}}

1. Install the required module for OpenLLMetry.

    ```bash
    python -m pip install traceloop-sdk
    ```{{exec}}

1. Set the environment variable to export the trace to the OLTP exporter.

    ```bash
    export TRACELOOP_BASE_URL="http://localhost:4318"
    ```{{exec}}

1. Execute the script.

    ```bash
    python sample_app/openai_mock_streaming_otel.py
    ```{{exec}}
