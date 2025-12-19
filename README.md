## Confidence + OpenFeature (Python) example

This repo contains a minimal Python script (`main.py`) that uses the **Spotify Confidence SDK** as an **OpenFeature provider**, then evaluates two string flag properties and prints their values.

### Requirements

- Python 3.9+ (recommended)

### Setup

Create a virtual environment and install dependencies:

```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

Set your Confidence client secret (do not commit secrets):

```bash
export CONFIDENCE_CLIENT_SECRET="<your-client-secret>"
```

### Run

```bash
python main.py
```

You should see output like:

- `Flag value: ...`
- `Flag 2 value: ...`

### Configuration

The script currently evaluates:

- `fdema-py.text`
- `fdema-py-2.subtitle`

Edit `FLAG_KEY`, `PROPERTY_NAME`, `FLAG_KEY_2`, and `PROPERTY_NAME_2` in `main.py` to match your flag keys and property names.
