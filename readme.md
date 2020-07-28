# installation
```
```

# how to use
```
# build image
make build
# start docker-compose
make start
# stop docker-compose
make stop
# remove image
make clean
```

# 注意事項とか
## 簡易ssh
 `make ssh` にて可能。dockerの性質上known_hostsがぶつかりやすいので適宜消す

## いちおうdocker in dockerも実現している。
windows docker hostの場合は

 ```docker container exec -it local bash```

からだと可能。 `make ssh` からは無理
