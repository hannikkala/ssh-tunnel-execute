# SSH Tunnel Execute

### Problem
Very often web application operations such as database backups and migrations can only be accessed through SSH jump server. While providing better security for application and data, it makes operational tasks more complicated.

### Solution
Docker image that can create all necessary SSH tunnels. Operations can easily be automated by extending the image for your own needs.

## Usage

Working example of extended image can be found [here](https://github.com/hannikkala/ssh-tunnel-execute/tree/master/example). The image backups PostgreSQL database into AWS S3.

## Enviroment variables

| Variable name         | Description                             |
| ----------------------|-----------------------------------------|
| SSH_USER_AND_HOST     | User name and host of the jump server. In format user@host |
| SSH_FORWARD_PORTS     | Tunnel forwarded ports. In format *port:remote_host:port*. <br>Example: **5432:postgresql.my.lan:5432** .<br>|