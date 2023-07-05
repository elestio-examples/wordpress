<a href="https://elest.io">
  <img src="https://elest.io/images/elestio.svg" alt="elest.io" width="150" height="75">
</a>

[![Discord](https://img.shields.io/static/v1.svg?logo=discord&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=Discord&message=community)](https://discord.gg/4T4JGaMYrD "Get instant assistance and engage in live discussions with both the community and team through our chat feature.")
[![Elestio examples](https://img.shields.io/static/v1.svg?logo=github&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=github&message=open%20source)](https://github.com/elestio-examples "Access the source code for all our repositories by viewing them.")
[![Blog](https://img.shields.io/static/v1.svg?color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=elest.io&message=Blog)](https://blog.elest.io "Latest news about elestio, open source software, and DevOps techniques.")

# Wordpress, verified and packaged by Elestio

[Wordpress](https://github.com/docker-library/wordpress) is the free, open-source WordPress software that you can install on your own web host to create a website that’s 100% your own.

Deploy a <a target="_blank" href="https://elest.io/open-source/wordpress">fully managed wordpress</a> on <a target="_blank" href="https://elest.io/">elest.io</a> if you want automated backups, reverse proxy with SSL termination, firewall, automated OS & Software updates, and a team of Linux experts and open source enthusiasts to ensure your services are always safe, and functional.

[![deploy](https://github.com/elestio-examples/wordpress/raw/main/deploy-on-elestio.png)](https://dash.elest.io/deploy?source=cicd&social=dockerCompose&url=https://github.com/elestio-examples/wordpress)

# Why use Elestio images?

- Elestio stays in sync with updates from the original source and quickly releases new versions of this image through our automated processes.
- Elestio images provide timely access to the most recent bug fixes and features.
- Our team performs quality control checks to ensure the products we release meet our high standards.

# Usage

## Git clone

You can deploy it easily with the following command:

    git clone https://github.com/elestio-examples/wordpress.git

Copy the .env file from tests folder to the project directory

    cp ./tests/.env ./.env

Edit the .env file with your own values.

Create data folders with correct permissions

    mkdir -p ./redis_data
    chown -R 1000:1000 ./redis_data

    mkdir -p ./db
    chown -R 1000:1000 ./db

    mkdir -p ./php.ini
    chown -R 1000:1000 ./php.ini

    mkdir -p ./wordpress
    chown -R 1000:1000 ./wordpress

Run the project with the following command

    docker-compose up -d

You can access the Web UI at: `http://your-domain:9000`

## Docker-compose

Here are some example snippets to help you get started creating a container.

    version: '3.3'
    services:
    redis:
        image: 'redis:alpine'
        ports:
            - '172.17.0.1:6379:6379'
        restart: always
        volumes:
        - ./redis_data:/data
    database:
        image: mysql:latest
        volumes:
            - ./db:/var/lib/mysql
        restart: always
        env_file:
            - .env
        environment:
            MYSQL_DATABASE: blog_wp
        command: '--default-authentication-plugin=mysql_native_password'
        cap_add:
            - SYS_NICE  # CAP_SYS_NICE
        networks:
            - blog-network
    wordpress:
        depends_on:
            - database
        image: wordpress:${SOFTWARE_VERSION_TAG}
        restart: always
        user: "root:root"
        dns: 
            - 8.8.8.8
        ports:
            - 172.17.0.1:9000:80
        env_file:
            - .env
        environment:
            - WORDPRESS_DB_HOST=database:3306
            - WORDPRESS_DB_USER=${MYSQL_USER}
            - WORDPRESS_DB_PASSWORD=${MYSQL_PASSWORD}
            - WORDPRESS_DB_NAME=blog_wp
        volumes:
            - ./php.ini:/usr/local/etc/php/conf.d/custom.ini
            - ./wordpress:/var/www/html
        networks:
            - blog-network
    phpmyadmin:
        image: phpmyadmin
        restart: always
        depends_on:
            - database
        environment:
            - PMA_HOST=database
            - PMA_PORT=3306
            - PMA_USER=wpdbuser
            - PMA_PASSWORD=${MYSQL_ROOT_PASSWORD}
            - MYSQL_USERNAME=wpdbuser
            - MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
        ports:
            - 172.17.0.1:24581:80
        networks:
            - blog-network
    networks:
        blog-network:
            driver: bridge



# Maintenance

## Logging

The Elestio Wordpress Docker image sends the container logs to stdout. To view the logs, you can use the following command:

    docker-compose logs -f

To stop the stack you can use the following command:

    docker-compose down

## Backup and Restore with Docker Compose

To make backup and restore operations easier, we are using folder volume mounts. You can simply stop your stack with docker-compose down, then backup all the files and subfolders in the folder near the docker-compose.yml file.

Creating a ZIP Archive
For example, if you want to create a ZIP archive, navigate to the folder where you have your docker-compose.yml file and use this command:

    zip -r myarchive.zip .

Restoring from ZIP Archive
To restore from a ZIP archive, unzip the archive into the original folder using the following command:

    unzip myarchive.zip -d /path/to/original/folder

Starting Your Stack
Once your backup is complete, you can start your stack again with the following command:

    docker-compose up -d

That's it! With these simple steps, you can easily backup and restore your data volumes using Docker Compose.

# Links

- <a target="_blank" href="https://github.com/docker-library/wordpress">Wordpress Github repository</a>

- <a target="_blank" href="https://wordpress.org/documentation/">Wordpress documentation</a>

- <a target="_blank" href="https://github.com/elestio-examples/wordpress">Elestio/wordpress Github repository</a>
