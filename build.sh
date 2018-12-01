#1/bin/bash
set -e
set -v
ARCH=unknown
if uname -a | grep -q 'x86_64'; then
   ARCH=amd64
fi
if uname -a | grep -q 'aarch64'; then
   ARCH=arm64
fi
if [ $ARCH == 'unknown' ]; then
    echo unknown architecture
    exit 1
fi

docker build -t runningman84/kube-router:$ARCH .
docker push runningman84/kube-router:$ARCH
