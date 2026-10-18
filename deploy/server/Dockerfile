# The fork's own gateway/Dockerfile needs Chainguard base images that this host cannot pull.
# The published proxy is the runtime. This layer adds the local gateway package, which that image does not ship.
ARG LITELLM_BASE=docker.litellm.ai/berriai/litellm:main-stable
FROM ${LITELLM_BASE}
COPY gateway /app/gateway
