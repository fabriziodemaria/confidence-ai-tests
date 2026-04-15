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
FLAG_KEY = "hide-campaigns-sidebar"
PROPERTY_NAME = "enabled"

# Create evaluation context with a targeting key
context = EvaluationContext(targeting_key="user-123")

# Fetch and print the string property
full_key = f"{FLAG_KEY}.{PROPERTY_NAME}"
value = client.get_boolean_value(full_key, False, context)

print(f"Flag value: {value}")

# Stale flag removed; keep previous default behavior.
value_2 = "Default subtitle"

print(f"Flag 2 value: {value_2}")

# E2E auto-created flags
e2e_flags = [
    "e2e-auto-created-flag-1769462017160",
    "e2e-auto-created-flag-1769458310951",
]

for flag_key in e2e_flags:
    full_key = f"{flag_key}.enabled"
    value = client.get_boolean_value(full_key, False, context)
    print(f"{flag_key}: {value}")
