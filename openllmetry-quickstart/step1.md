# Step 1: Call openai-mock

1. Create the scrypt which will call [openai-mock](https://api.openai-mock.com/#introduction).

    ```bash
    touch sample_app/openai_mock_streaming.py
    ```{{exec}}

1. Copy and paste the code below to the file you have created.

    ```py
    import os
    from flask import Flask, jsonify
    from openai import OpenAI

    app = Flask(__name__)

    client = OpenAI(
        api_key=os.environ["OPENAI_API_KEY"],
        base_url=os.environ["OPENAI_BASE_URL"],
    )

    def create_joke():
        completion = client.chat.completions.create(
            model="gpt-3.5-turbo",
            messages=[{"role": "user", "content": "<<short>>Tell me a joke about opentelemetry"}],
        )

        return completion.choices[0].message.content

    def translate_joke_to_pirate(joke: str):
        completion = client.chat.completions.create(
            model="gpt-3.5-turbo",
            messages=[{"role": "user", "content": f"<<medium>>Translate the below joke to pirate-like english:\n\n{joke}"}],
        )

        history_jokes_tool()

        return completion.choices[0].message.content

    def history_jokes_tool():
        completion = client.chat.completions.create(
            model="gpt-3.5-turbo",
            messages=[{"role": "user", "content": f"<<long>>get some history jokes"}],
        )

        return completion.choices[0].message.content

    @app.route('/')
    def joke_workflow():
        eng_joke = create_joke()
        pirate_joke = translate_joke_to_pirate(eng_joke)
        print(pirate_joke)
        return jsonify(pirate_joke)
        
    if __name__ == "__main__":
        app.run()
    ```{{copy}}

1. Install the required packages.

    ```bash
    python -m pip install openai flask
    ```{{exec}}

1. Set the environment variables.

    ```bash
    export OPENAI_API_KEY="sk-0"
    export OPENAI_BASE_URL="https://api.openai-mock.com"
    ```{{exec}}

1. Execute the script.

    ```bash
    python -m flask --app sample_app/openai_mock_streaming.py run -h 0.0.0.0 -p 8080
    ```{{exec}}
