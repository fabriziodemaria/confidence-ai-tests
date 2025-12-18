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

# Replace with your actual flag key and property name
FLAG_KEY = "fdema-py"
PROPERTY_NAME = "text"

# Create evaluation context with a targeting key
context = EvaluationContext(targeting_key="user-123")

# Fetch and print the string property
full_key = f"{FLAG_KEY}.{PROPERTY_NAME}"
value = client.get_string_value(full_key, "HI! How are you?", context)

print(f"Flag value: {value}")

