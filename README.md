# Redis manager

[GitHub](https://github.com/ngbdf/redis-manager)|[码云](https://gitee.com/newegg/redis-manager)

## Start a redis-manager

### Update config by environment variables

 If you don't need to modify too much configuration information, you can modify the configuration file by configuring environment variables.

```sh
$sudo docker run -d --net=host --name redis-manager  \
-e DATASOURCE_DATABASE='redis_manager' \
-e DATASOURCE_URL='jdbc:mysql://127.0.0.1:3306/redis_manager?useUnicode=true&characterEncoding=utf-8&serverTimezone=GMT%2b8' \
-e DATASOURCE_USERNAME='root' \
-e DATASOURCE_PASSWORD='******' \
reasonduan/redis-manager
```

### Use the configuration file on the host

```sh
$sudo docker run -d --net=host --name redis-manager  \
-v /opt/app/redis-manager/conf/application.yml:/usr/local/redis-manager/conf/application.yml \
reasonduan/redis-manager
```

### Update config by remote file

If you need to change a lot of configuration information, you can update your configuration by configuring a remote configuration file.

```sh
$sudo docker run -d --net=host --name redis-manager  \
-e CONFIG_URL='http://127.0.0.1/config/raw/master/redis_manager/application.yml' \
reasonduan/redis-manager
```
