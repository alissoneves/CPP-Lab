FROM ubuntu:22.04

WORKDIR /app

RUN apt-get update && \
    apt-get install -y libfmt-dev

COPY build/cpp_lab /app/cpp_lab

RUN chmod +x /app/cpp_lab

CMD ["sh", "-c", "./cpp_lab && sleep infinity"]