FROM python:3.13-slim AS builder

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    UV_COMPILE_BYTECODE=1

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

COPY services/identity-service/pyproject.toml ./
COPY services/identity-service/uv.lock ./ 

RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --frozen --no-install-project --no-dev

FROM python:3.13-slim AS runtime

RUN apt-get update && apt-get install -y --no-install-recommends \
    libpq5 \
    && rm -rf /var/lib/apt/lists/* \
    && groupadd -r appuser && useradd -r -g appuser appuser

RUN mkdir -p /mnt/efs/drafts && chown -R appuser:appuser /mnt/efs/drafts

WORKDIR /app

COPY --from=builder /app/.venv /app/.venv
ENV PATH="/app/.venv/bin:$PATH"

COPY services/identity-service/app /app/app
COPY services/shared /app/shared

RUN chown -R appuser:appuser /app
USER appuser

EXPOSE 8000

CMD ["fastapi", "run", "app/main.py", "--proxy-headers", "--port", "8000"]