# Docker Openfire by jonz94

![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/jonz94/openfire.svg)
![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/jonz94/openfire.svg)
[![](https://images.microbadger.com/badges/version/jonz94/openfire.svg)](https://microbadger.com/images/jonz94/openfire)
[![](https://images.microbadger.com/badges/image/jonz94/openfire.svg)](https://microbadger.com/images/jonz94/openfire)

Docker image for Openfire XMPP Server

<!-- vim-markdown-toc GFM -->

* [Usage (Example)](#usage-example)
* [Upgrade/Downgrade](#upgradedowngrade)
* [Knowing issues and/or solutions](#knowing-issues-andor-solutions)
    * [Using mysql with UTF-8, openfire failed to start](#using-mysql-with-utf-8-openfire-failed-to-start)

<!-- vim-markdown-toc -->

## Usage (Example)

1. Pull latest image

```
$ docker pull jonz94/openfire:latest
```

2. Run openfire as daemon, and store important files in docker volumes

    * Using bridge networks

    ```
    $ docker run \
        --detach \
        --name my_awesome_openfire_container_name \
        --publish 3478:3478 \
        --publish 3479:3479 \
        --publish 5222:5222 \
        --publish 5223:5223 \
        --publish 5229:5229 \
        --publish 7070:7070 \
        --publish 7443:7443 \
        --publish 7777:7777 \
        --publish 9090:9090 \
        --publish 9091:9091 \
        --restart always \
        --volume openfire-config:/etc/openfire \
        --volume openfire-data:/var/lib/openfire \
        --volume openfire-log:/var/log/openfire \
        jonz94/openfire:latest
    ```

    * Or, using host networking

    ```
    $ docker run \
        --detach \
        --name my_awesome_openfire_container_name \
        --network host \
        --restart always \
        --volume openfire-config:/etc/openfire \
        --volume openfire-data:/var/lib/openfire \
        --volume openfire-log:/var/log/openfire \
        jonz94/openfire:latest
    ```

3. Open browser, visit http://localhost:9090, and walk through initial setup for openfire

4. Done

## Upgrade/Downgrade

1. To upgrade openfire image, you need to stop and remove the running openfire container

```
$ docker stop my_awesome_openfire_container_name
$ docker rm my_awesome_openfire_container_name
```

2. Pull latest image (or specific tag version you want to use)

```
# pull latest
$ docker pull jonz94/openfire:latest

# pull 4.3.2-1
$ docker pull jonz94/openfire:4.3.2-1
```

3. Start openfire via the same command/method you start openfire container last time

    * e.g.

    ```
    $ docker run \
        --detach \
        --name my_awesome_openfire_container_name \
        --network host \
        --restart always \
        --volume openfire-config:/etc/openfire \
        --volume openfire-data:/var/lib/openfire \
        --volume openfire-log:/var/log/openfire \
        jonz94/openfire:latest
    ```

    * Or, with specific tag version

    ```
    $ docker run \
        --detach \
        --name my_awesome_openfire_container_name \
        --network host \
        --restart always \
        --volume openfire-config:/etc/openfire \
        --volume openfire-data:/var/lib/openfire \
        --volume openfire-log:/var/log/openfire \
        jonz94/openfire:4.3.2-1
    ```

## Knowing issues and/or solutions

### [Using mysql with UTF-8, openfire failed to start](https://discourse.igniterealtime.org/t/issue-when-restart-openfire-server-after-setup-openfire-using-mysql-with-utf-8-encode-via-a-fresh-installation/84011)

* solution:

    1. Fix `openfire.xml` configuration file:

    ```
    $ docker exec -it my_awesome_openfire_container_name \
        sed -i "s/\&amp;amp;/\&amp;/g" /etc/openfire/openfire.xml
    ```

    2. restart openfire container

    ```
    $ docker restart my_awesome_openfire_container_name

    # or stop, rm, and then start a brand-new container
    $ docker stop my_awesome_openfire_container_name
    $ docker rm my_awesome_openfire_container_name
    $ docker run --detach --name my_awesome_openfire_container_name ...
    ```
