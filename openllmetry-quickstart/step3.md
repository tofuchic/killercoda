# Step 3: Instrument OpenLLMetry

1. Create the script which will call [openai-mock](https://api.openai-mock.com/#introduction) and **send the Generative AI specific trace** to the APM.

    ```bash
    touch sample_app/openai_mock_streaming_openllmetry.py
    ```{{exec}}

1. Copy and paste the code below to the file you have created.

    ```py
    import os
    from flask import Flask, jsonify
    from openai import OpenAI
    from traceloop.sdk import Traceloop
    from traceloop.sdk.decorators import workflow

    Traceloop.init(disable_batch=True)

    app = Flask(__name__)

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

    @app.route('/')
    @workflow(name="joke_workflow")
    def joke_workflow():
        eng_joke = create_joke()
        pirate_joke = translate_joke_to_pirate(eng_joke)
        print(pirate_joke)
        return jsonify(pirate_joke)
        
    if __name__ == "__main__":
        app.run()
    ```{{copy}}

1. (Optional because you have done in Step 1.) Set the environment variables.

    ```bash
    export OPENAI_API_KEY="sk-0"
    export OPENAI_BASE_URL="https://api.openai-mock.com"
    ```{{exec}}

1. (Optional because you have executed in Step 2.)Setup the OTel server: [Jaeger](https://www.jaegertracing.io/). **Execute the command below in the right-side☞ terminal.**

    ```bash
    docker run --rm --name jaeger \
    -e COLLECTOR_OTLP_GRPC_HOST_PORT=:4317 \
    -p 16686:16686 \
    -p 4317:4317 \
    jaegertracing/all-in-one:1.59
    ```{{exec}}

1. Install the required module for OpenLLMetry.

    ```bash
    python -m pip install traceloop-sdk
    ```{{exec}}

1. Set the environment variable to export the trace to the OLTP exporter.

    ```bash
    export TRACELOOP_BASE_URL="http://localhost:4317"
    export TRACELOOP_TELEMETRY=false
    ```{{exec}}

1. Execute python script with auto-instrument command.

    ```bash
    .venv/bin/opentelemetry-instrument \
    --traces_exporter console,otlp \
    --service_name openai-mock-app \
    --exporter_otlp_logs_protocol grpc \
    --exporter_otlp_endpoint localhost:4317 \
    --exporter_otlp_traces_insecure true \
    python -m flask --app sample_app/openai_mock_streaming_openllmetry.py run -h 0.0.0.0 -p 8080
    ```{{exec}}

1. [Access to the flask app]({{TRAFFIC_HOST1_8080}}).

    - Verify you can get the mock response.

1. [Access to the Jaeger UI]({{TRAFFIC_HOST1_16686}}).

    - Verify you can see the distributed tracing, and they includes the LLM specific infomation.
