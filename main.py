from confidence.confidence import Confidence
from confidence.openfeature_provider import ConfidenceOpenFeatureProvider
from openfeature import api
from openfeature.evaluation_context import EvaluationContext
import os

CLIENT_SECRET_ENV_VAR = "CONFIDENCE_CLIENT_SECRET"
client_secret = os.getenv(CLIENT_SECRET_ENV_VAR)
if not client_secret:
    raise RuntimeError(
        f"Missing required environment variable: {CLIENT_SECRET_ENV_VAR}. "
        f"Set it to your Confidence client secret."
    )

# Initialize the Confidence SDK
confidence = Confidence(client_secret=client_secret)

# Create and set the OpenFeature provider
provider = ConfidenceOpenFeatureProvider(confidence)
api.set_provider(provider)

# Get the OpenFeature client
client = api.get_client()

# Replace with your actual flag key and property name
FLAG_KEY = "fdema-py"
PROPERTY_NAME = "text"

# Create evaluation context with a targeting key
context = EvaluationContext(targeting_key="user-123")

# Fetch and print the string property
full_key = f"{FLAG_KEY}.{PROPERTY_NAME}"
value = client.get_string_value(full_key, "Hi! How are you?", context)

print(f"Flag value: {value}")

# Second flag
FLAG_KEY_2 = "fdema-py-2"
PROPERTY_NAME_2 = "subtitle"

full_key_2 = f"{FLAG_KEY_2}.{PROPERTY_NAME_2}"
value_2 = client.get_string_value(full_key_2, "Default subtitle", context)

print(f"Flag 2 value: {value_2}")
