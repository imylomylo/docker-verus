# docker-verus
Requires docker-compose and docker installed.

These are rough instructions


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

