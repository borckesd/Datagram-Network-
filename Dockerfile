FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*

COPY datagram-cli /app/datagram-cli

WORKDIR /app

ENTRYPOINT ["./datagram-cli"]

