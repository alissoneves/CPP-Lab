FROM ubuntu:22.04

WORKDIR /app

COPY build/cpp_lab /app/cpp_lab
COPY build/libfmt.so.9 /lib/x86_64-linux-gnu/libfmt.so.9

RUN chmod +x /app/cpp_lab

CMD ["./cpp_lab"]
CMD ["sh", "-c", "./cpp_lab && sleep infinity"]