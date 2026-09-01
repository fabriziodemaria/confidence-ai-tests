# confidence-ai-tests

A small Python example that evaluates [Confidence](https://confidence.spotify.com/)
feature flags through the [OpenFeature](https://openfeature.dev/) SDK.

The script in `main.py` initializes the Confidence SDK, registers it as an
OpenFeature provider, and reads a few flag values for a sample evaluation
context.

## Requirements

- Python 3.8+
- The dependencies listed in [`requirements.txt`](requirements.txt):
  - `spotify-confidence-sdk`
  - `openfeature-sdk`

## Setup

```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

## Configuration

`main.py` reads flag values with a hardcoded client secret and targeting key.
Update the following values in `main.py` to match your own Confidence account
before running:

- `CLIENT_SECRET` – the client secret for your Confidence client.
- `FLAG_KEY` / `PROPERTY_NAME` – the flag and property you want to evaluate.
- The `targeting_key` used to build the `EvaluationContext`.

## Usage

```bash
python main.py
```

The script prints the resolved value for each configured flag, falling back to
the provided defaults when a flag cannot be resolved.
