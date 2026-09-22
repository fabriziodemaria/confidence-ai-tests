# confidence-ai-tests 🚀

A minimal Python example that evaluates feature flags with the
[Spotify Confidence](https://confidence.spotify.com/) SDK through the
[OpenFeature](https://openfeature.dev/) API.

## Contents

- `main.py` — example script that initializes the Confidence SDK, registers it
  as an OpenFeature provider, and reads a few flag values (boolean and string)
  for a sample evaluation context.
- `requirements.txt` — Python dependencies (`spotify-confidence-sdk`,
  `openfeature-sdk`).

## Setup

Requires Python 3. Install the dependencies (a virtual environment is
recommended):

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

## Usage

```bash
python3 main.py
```

The script prints the evaluated flag values to stdout.

The Confidence client secret and the flag keys in `main.py` are hardcoded
sample values. Replace `CLIENT_SECRET` and the flag/property names with your
own to evaluate against your Confidence account.

## Tests

This repository contains no automated tests; `main.py` is the runnable example.
