# Anki Docker Sync Server

As of Anki 2.1.57, Anki now comes bundled with a self-hosted sync server with its own
[documentation](https://docs.ankiweb.net/sync-server.html).

Users who has upgraded their clients to the new Anki version will find that their clients
are incompatible with some old servers, such as [this](https://github.com/ankicommunity/anki-sync-server).

Hence, there is impetus to upgrade. This docker image supports SSL via [suyashkumar/ssl-proxy](https://github.com/suyashkumar/ssl-proxy)
which is necessary when connecting the mobile clients to the sync server.

## Non-SSL Usage

### Docker Compose

You will need `docker-compose.yml`. Modify `.env` and update the desired username & password:
```
SYNC_USER1=user:password
SYNC_USER2=user:password
...
```

There must be at least one configured user. Then, run Docker compose:
```
docker compose up -d
```

### Normal Docker

```
$ mkdir data
$ docker run -p 8080:8080 -e $PWD/data:/opt/anki -e SYNC_USER1=user:password jameshi16/anki-docker-sync-server
```

This will run Anki sync server at port 8080, and persist all flashcards or media in the `data/` folder.

## SSL Usage

### Docker Compose

You will need `docker-compose-ssl.yml` renamed to `docker-compose.yml` to make things easier.
Copy `.env.ssl` and update the desired username & password. If you need to change the names of the SSL certificate
or key, then change those fields as well.

```
SYNC_USER1=user:password
SYNC_USER2=user:password
...
```

There must at least be one configured user. Copy the server cetificate (must also include the CA root certificate), and server key into the `ssl/` sub-directory. This can be a [LetsEncrypt certificate](https://certbot.eff.org/instructions?ws=other&os=debianbuster) or a self-generated certificate; a rough guide can be found [in my wiki](https://wiki.codingindex.xyz/self-signed-certificates).

Do note that if the certificates are not properly generated (missing `subjectAltNames`, wrong IP addresses, etc), mobile clients may complain and fail to connect to the server.

The root certificates should be installed in all your devices connecting to this server.

The directory structure should minimally look like this:

```
ssl/server.crt
ssl/domain.key
.env.ssl
docker-compose.yml
```

Then, run Docker Compose:
```
docker compose up -d
```

# License

MIT License.
