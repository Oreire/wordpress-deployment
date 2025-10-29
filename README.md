# wordpress-deployment
Automation of the Deployment of WordPress Using Terraform, Ansible and GitHub Actions

# Step-by-Step WordPress Configuration on Azure VM (LEMP Stack)

# 1. **Update System and Install Core Packages**

```bash
apt update && apt upgrade -y
apt install -y nginx mariadb-server php php-fpm php-mysql php-cli php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip unzip wget
```

---

### 🗄️ 2. **Secure MariaDB and Create WordPress Database**

```bash
mysql_secure_installation
mysql -u root -p
```

Inside the MariaDB shell:

```sql
CREATE DATABASE wordpress;
CREATE USER 'wpuser'@'localhost' IDENTIFIED BY 'securepassword';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

---

# 🌐 3. **Download and Configure WordPress**

```bash
cd /var/www/
wget https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz
mv wordpress yourdomain
chown -R www-data:www-data /var/www/yourdomain
chmod -R 755 /var/www/yourdomain


# Copy and edit the config file:

```bash
cp /var/www/yourdomain/wp-config-sample.php /var/www/yourdomain/wp-config.php
nano /var/www/yourdomain/wp-config.php
```

# Update DB settings: 

```php
define('DB_NAME', 'wordpress');
define('DB_USER', 'sensitive');
define('DB_PASSWORD', 'sensitive');
define('DB_HOST', 'localhost');
```

### ⚙️ 4. **Configure NGINX for WordPress**

Create a new site config:

```bash
nano /etc/nginx/sites-available/wordpress
```

Jinja file

Enable and reload:

```bash
ln -s /etc/nginx/sites-available/wordpress /etc/nginx/sites-enabled/
nginx -t
systemctl reload nginx
```

### 🔐 5. **Secure with SSL (Optional)**

```bash
apt install certbot python3-certbot-nginx
certbot --nginx -d yourdomain.com
```

---

### 🧪 6. **Access WordPress Installer**

Visit http://172.167.226.39 in the browser and complete the WordPress setup.


## ✅ Current Status Summary

| Component     | Status                                                                 |
|---------------|------------------------------------------------------------------------|
| **WordPress** | ✅ Installed at `/var/www/yourdomain` with all core files present       |
| **MariaDB**   | ✅ Database `wordpress` and user `wpuser` created and verified          |
| **PHP-FPM**   | ✅ Active and running (`php8.1-fpm`) as confirmed by systemd logs       |
| **NGINX**     | ✅ Configured to serve WordPress (verify root path and PHP block)       |


