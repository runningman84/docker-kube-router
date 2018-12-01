FROM golang
# depdency tool
RUN go get github.com/golang/dep/cmd/dep
RUN go install github.com/golang/dep/cmd/dep

# gobgp
RUN go get github.com/osrg/gobgp/cmd/gobgp
RUN cd $GOPATH/src/github.com/osrg/gobgp && dep ensure
RUN GOOS=linux CGO_ENABLED=0 go install github.com/osrg/gobgp/cmd/gobgp

# kube-router
RUN go get github.com/cloudnativelabs/kube-router/cmd/kube-router
RUN cd $GOPATH/src/github.com/cloudnativelabs/kube-router/ && dep ensure
RUN GOOS=linux CGO_ENABLED=0 go install github.com/cloudnativelabs/kube-router/cmd/kube-router

FROM alpine

RUN apk add --no-cache \
      iptables \
      ipset \
      iproute2 \
      ipvsadm \
      conntrack-tools \
      curl \
      bash && \
    mkdir -p /var/lib/gobgp && \
    mkdir -p /usr/local/share/bash-completion && \
    curl -L -o /usr/local/share/bash-completion/bash-completion \
        https://raw.githubusercontent.com/scop/bash-completion/master/bash_completion

COPY --from=0 /go/src/github.com/cloudnativelabs/kube-router/build/image-assets/bashrc /root/.bashrc
COPY --from=0 /go/src/github.com/cloudnativelabs/kube-router/build/image-assets/profile /root/.profile
COPY --from=0 /go/src/github.com/cloudnativelabs/kube-router/build/image-assets/vimrc /root/.vimrc
COPY --from=0 /go/src/github.com/cloudnativelabs/kube-router/build/image-assets/motd-kube-router.sh /etc/motd-kube-router.sh
COPY --from=0 /go/bin/kube-router /usr/local/bin/kube-router
COPY --from=0 /go/bin/gobgp /usr/local/bin/gobgp

RUN cd && /usr/local/bin/gobgp --gen-cmpl --bash-cmpl-file /var/lib/gobgp/gobgp-completion.bash

WORKDIR "/root"
ENTRYPOINT ["/usr/local/bin/kube-router"]