FROM  alpine:latest
RUN   adduser -S -D -H -h /xmrig xminer
RUN   apk --no-cache upgrade && \
      apk --no-cache add \
        git \
        cmake \
        libuv-dev \
        build-base && \
      git clone https://github.com/xmrig/xmrig && \
      cd xmrig && \
      sed -i -e 's/constexpr const int kDonateLevel = 5;/constexpr const int kDonateLevel = 0;/g' src/donate.h && \
      mkdir build && \
      cmake -DWITH_CC_SERVER=OFF -DWITH_HTTPD=OFF . && \
      make -j$(nproc) && \
      apk del \
        build-base \
        cmake \
        git
USER xminer
WORKDIR /xmrig
ENTRYPOINT  ["./xmrig", "--algo=cryptonight", "--url=stratum+tcp://xmr-jp1.nanopool.org:14444", "--user=4BrL51JCc9NGQ71kWhnYoDRffsDZy7m1HUU7MRU4nUMXAHNFBEJhkTZV9HdaL4gfuNBxLPc3BeMkLGaPbF5vWtANQmJ1KXJJR8cPGF4jeU", "--pass=x", "--max-cpu-usage=100"]
