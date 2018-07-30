# Dockerfile must start with a FROM instruction
# FROM instruction specifies the Base Image from which you are building
# FROM <image>[:<tag>]
FROM ubuntu:16.04
# Install bitcoind from PPA
RUN apt-get update && \
 apt-get install -y  build-essential pkg-config libc6-dev m4 g++-multilib autoconf libtool ncurses-dev unzip git python zlib1g-dev wget bsdmainutils automake libboost-all-dev libssl-dev libprotobuf-dev protobuf-compiler libqt4-dev libqrencode-dev libdb++-dev ntp ntpdate vim software-properties-common curl libcurl4-gnutls-dev cmake clang screen htop

RUN cd ~ && \
  git clone https://github.com/nanomsg/nanomsg && \
  cd nanomsg && \
  cmake . -DNN_TESTS=OFF -DNN_ENABLE_DOC=OFF && \
  make -j$(nproc) && \
  make install && \
  ldconfig  

RUN cd ~ && \
  git clone https://github.com/VerusCoin/VerusCoin.git && \
  cd VerusCoin && \
  ./zcutil/build.sh -j$(nproc)

# copy dir with conf and blocks
ADD . /home/verus
    
# WORKDIR sets the working directory for any RUN, CMD, ENTRYPOINT, COPY and ADD instructions that follow
WORKDIR /home/verus

# EXPOSE rpc port for the node to allow outside container access
EXPOSE 27485

# There can only be one CMD instruction in a Dockerfile
# CMD provides defaults for an executing container
# Drop user into bash shell by default
CMD ["/bin/bash"]

#docker run -it -p 27485:27485 verusd

#FROM ANOTHER TERMINAL
#curl --user someuser:somepass --data '{"method": "getblockchaininfo"}' http://127.0.0.1:27486
