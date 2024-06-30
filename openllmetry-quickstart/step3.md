# Step 1: Instrument OpenLLMetry

1. Create the script which will call [openai-mock](https://api.openai-mock.com/#introduction) and send the **Generative AI specific** trace to the APM.

    ```bash
    touch sample_app/openai_mock_streaming_llmetry.py
    ```{{exec}}

1. Copy and paste the code below to the file you have created.

    ```
    import os
    from openai import OpenAI

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

    def joke_workflow():
        eng_joke = create_joke()
        pirate_joke = translate_joke_to_pirate(eng_joke)
        print(pirate_joke)
        
    if __name__ == "__main__":
        joke_workflow()
    ```{{copy}}

1. (Optional because you have done in Step 1.) Set the environment variables.

    ```bash
    export OPENAI_API_KEY="sk-0"
    export OPENAI_BASE_URL="https://api.openai-mock.com"
    ```{{exec}}

1. (Optional because you have done in Step 2.)Setup the OTel server.

<!-- TBD -->

1. Execute the script.

    ```bash
    python sample_app/openai_mock_streaming_llmetry.py
    ```{{exec}}
