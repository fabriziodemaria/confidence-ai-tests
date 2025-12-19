from confidence.confidence import Confidence
from confidence.openfeature_provider import ConfidenceOpenFeatureProvider
from openfeature import api
from openfeature.evaluation_context import EvaluationContext

# Replace with your actual client secret
CLIENT_SECRET = "in4jCyVWyrqezcY5lMqdPsl170s7w5FF"

# Initialize the Confidence SDK
confidence = Confidence(client_secret=CLIENT_SECRET)

# Create and set the OpenFeature provider
provider = ConfidenceOpenFeatureProvider(confidence)
api.set_provider(provider)

# Get the OpenFeature client
client = api.get_client()

# Create evaluation context with a targeting key
context = EvaluationContext(targeting_key="user-123")

# This flow previously relied on a flag; keep the prior default response.
greeting_text = "Hi! How are you?"
print(f"Greeting message: {greeting_text}")

# Second flag
FLAG_KEY_2 = "fdema-py-2"
PROPERTY_NAME_2 = "subtitle"

full_key_2 = f"{FLAG_KEY_2}.{PROPERTY_NAME_2}"
value_2 = client.get_string_value(full_key_2, "Default subtitle", context)

print(f"Flag 2 value: {value_2}")
