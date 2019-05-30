# Example of PostgreSQL backup through SSH tunnel.

This image uses **hannikkala/ssh-tunnel-execute** as SSH tunnel creator in order to backup PostgreSQL database behind the jump server.

This image uses https://github.com/heyman/docker-postgres-backup for backup operations.

## Usage

#### 1. Rename *.env.example* to *.env* 
```bash
$ mv .env.example .env
```

#### 2. Modify *.env* according to your enviroment
```bash
# If you use the default profile, set value to default 
AWS_PROFILE=my_profile

# S3 Bucket to backup into. Must exist.
S3_PATH=s3://my_bucket/

# Always localhost because it's local tunneled.
DB_HOST=localhost

# Name of your database
DB_NAME=database

# User name for database. Must have read privileges.
DB_USER=username

# Password for database.
DB_PASS=password

# user@host of your SSH jump server
SSH_USER_AND_HOST=me@my-firewall.our.lan

# Port forwarding definitions. If you have multiple, separate by space.
SSH_FORWARD_PORTS=5432:mydatabase.our.lan:5432
```

#### 3. Modify *docker-compose-yml* according to your enviroment
```yaml
version: '3.7'
services:
  backup:
    image: hannikkala/ssh-tunnel-postgresql-demo
    build:
      context: .
    environment:
      - AWS_PROFILE=${AWS_PROFILE}
      - S3_PATH=${S3_PATH}
      - DB_HOST=${DB_HOST}
      - DB_NAME=${DB_NAME}
      - DB_USER=${DB_USER}
      - DB_PASS=${DB_PASS}
      - SSH_USER_AND_HOST=${SSH_USER_AND_HOST}
      - SSH_FORWARD_PORTS=${SSH_FORWARD_PORTS}
    volumes:
      - ~/.ssh/id_rsa:/root/.ssh/id_rsa
      - ~/.aws/credentials:/root/.aws/credentials
      - ./backups:/backups
    command: sh -c "python backup.py"
```

As you can see, docker-compose.yml uses local SSH key and AWS credentials file to create SSH connection and upload to S3 respectively.

#### 4. Run *docker-compose up backup*

You should get output like below.  
```bash
$ docker-compose up backup
Starting example_backup_1 ... done
Attaching to example_backup_1
backup_1  | [2019-05-30 15:27:11]: Dumping database
backup_1  | [2019-05-30 15:30:19]: Uploading to S3
backup_1  | [2019-05-30 15:31:04]: Pruning local backup copies
backup_1  | [2019-05-30 15:31:04]: Backup complete, took 233.66 seconds
example_backup_1 exited with code 0
```