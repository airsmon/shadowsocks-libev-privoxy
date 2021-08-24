# shadowsocks-libev and privoxy

## Installation

### Distribution-specific guide

- [Docker]
    + [Alpine](#alpine-image-build)


### Alpine
First clone the shadowsocks-libev warehouse and cover shadowsocks-libev with the contents of this warehouse.

```bash
# clone shadowsocks-libev
git clone https://github.com/shadowsocks/shadowsocks-libev.git

# Generate libbloom
git submodule init && git submodule update

# clone 
git clone git@github.com:airsmon/shadowsocks-libev-privoxy.git
```

### build
```bash
# Copy files to overwrite
cd shadowsocks-libev && cp -rp ../shadowsocks-libev-privoxy/docker .

# build image
docker build .

# Modify the mirror tag
docker image tag SOURCE_IMAGE[:TAG] TARGET_IMAGE[:TAG]
```
### running
```bash
docker run -d -e SERVER_HOST="address" -e SERVER_PORT="port" -e PASSWORD="password" -e ENCRYPT_METHOD="aes-256-cfb" -e LOCAL_ADDRESSS="0.0.0.0" -e LOCAL_PORT="1080" -v /root/config:/etc/privoxy/config -p 8118:8118 
```
