# syntax=docker/dockerfile:1
# ---------------------------------------------------------------------------
# Hermes Agent — Railway deployment wrapper
# Thin pass-through to the official nousresearch/hermes-agent image.
# ---------------------------------------------------------------------------
FROM nousresearch/hermes-agent:latest

# Railway reads EXPOSE for port detection
EXPOSE 8642
EXPOSE 9119

# Default: run as persistent gateway
CMD ["gateway", "run"]
