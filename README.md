# docker-verus
Requires docker-compose and docker installed.

These are rough instructions - note the important section at the end.


Locally your user needs zcash-params. So, `./run-get-zcash-params`

Then you need to build the container

```
docker-compose build
```

Then you need to download the bootstrap (unless you want to sync from scratch, the correct way to run things in a self-sovereign way)
```
./run-get-bootstrap
```

Then start the compose
```
docker-compose up
```

To stop, add extra time because verusd does many indexing tasks and clean up
```
docker-compose stop -t 45 verusd
```

== Important

A user reported they have trouble running verusd in a docker container, but this is not something I have observed.

I have been using `docker-compose stop -t 45 verusd` to give the docker processes more time to wait for the SIGTERM process to complete - this is equivalent to `kill -15` which is a polite way to kill a process. After the time out of 45s (default docker timeout is 10s), the SIGKILL signal is sent, equivalent to `kill -9` which kills the process without waiting for any administrative tasks it might be doing.
