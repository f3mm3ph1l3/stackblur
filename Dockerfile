# base golang builder image
FROM golang:1.19.4 as builder

# setup workdir
WORKDIR /stackblur

# turn off CGO
ENV CGO_ENABLED=0

# get source
COPY . .

# now build
RUN cd cmd && go build -o /go/bin/stackblur

# set final base image
FROM scratch as binary

# get stackblur binary
COPY --from=builder /go/bin/ /usr/bin/

# create workdir
WORKDIR /home

# set entry
ENTRYPOINT ["/usr/bin/stackblur"]
