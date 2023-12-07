# WORDPRESS + MySQL + PhpMyAdmin docker-compose demo CI/CD pipeline

<a href="https://dash.elest.io/deploy?source=cicd&social=dockerCompose&url=https://github.com/elestio-examples/wordpress"><img src="deploy-on-elestio.png" alt="Deploy on Elest.io" width="180px" /></a>

Example application and CI/CD pipeline showing how to deploy a WordPress + MySQL + PhpMyAdmin docker-compose to elestio.

<img src="wordpress.png" style='width: 100%;'/>
<br/>
<br/>

# Once deployed ...

You can open the WordPress admin panel here:

    https://[CI_CD_DOMAIN]/wp-admin
    Login: [ADMIN_EMAIL] (set in env var)
    password: [ADMIN_PASSWORD] (set in env var)

You can connect to your DB through PHPMyAdmin:

    https://[CI_CD_DOMAIN]:24580/
    Login: root (set in reverse proxy configuration)
    Password: [ADMIN_PASSWORD] (set in reverse proxy configuration)

# Redis

You can activate the Redis cache by following the below steps:
1. Go to Service/Pipeline.
2. Click on Tools
3. Open Vs Code
4. Open `wp-config.php` file inside the WordPress folder.
5. Add the below both lines at the end of the `wp-config.php` file.
   
    define('WP_REDIS_HOST', '172.17.0.1');
   
    define('WP_REDIS_PORT', '6379');
   
7. Now open the WordPress application admin.
8. Go to the plugins section => installed plugins.
9. Find the `Redis Object Cache` plugin. if not found install it.
10. Click on `Settings` below `Redis Object Cache`, then click on the `Enable Object Cache` button
