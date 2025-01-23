# Radius Sever Configuration

## Pre-requisites

Linux Machine with Ubuntu 18.04 Desktop OS installed.

## Getting Started

Update system package to the latest version with the following command: 
```
apt-get update -y
apt-get upgrade -y
```

Restart system once all the packages are updated to apply all the configuration changes

## Install LAMP Server

Need to install Apache, MariaDB, PHP and other required packages to your system. You can install all of them with the following command: 

```
apt-get install apache2 mariadb-server php libapache2-mod-php php-mail php-mail-mime php-mysql php-gd php-common php-pear php-db php-mbstring php-xml php-curl unzip wget -y
```

Once all the packages installed, you can proceed to the next step. 


## Configure Database for FreeRADIUS

By default, MariaDB is not secured, so you will need to secure it first. You can secure it with the following command: 

```
mysql_secure_installation
```

Answer all the questions as shown below:

```
Enter current password for root (enter for none): Just press the Enter
Set root password? [Y/n]: Y
New password: Enter password
Re-enter new password: Repeat password
Remove anonymous users? [Y/n]: Y
Disallow root login remotely? [Y/n]: Y
Remove test database and access to it? [Y/n]:  Y
Reload privilege tables now? [Y/n]:  Y
```

Next, you will need to create a database and user for FreeRADIUS. To do so, log in to MariaDB shell with the following command: 

```
mysql -u root -p
```

Enter your root password when prompt then create a database and user with the following command: 

```
MariaDB [(none)]> CREATE DATABASE radiusdb;
MariaDB [(none)]> GRANT ALL ON radiusdb.* TO radius@localhost IDENTIFIED BY "password";
```

Next, flush the privileges and exit from the MariaDB shell with the following command: 

```
MariaDB [(none)]> FLUSH PRIVILEGES;
MariaDB [(none)]> EXIT;
```

Once you have finished, you can proceed to the next step. 

## Install Free RADIUS

By default, Free RADIUS is available in the Ubuntu 18.04 default repository. You can install it with the following command:

```
apt-get install freeradius freeradius-mysql freeradius-utils
```

Once installed, import the freeradius MySQL database schema with the following command: 

```
mysql -u root -p radiusdb < /etc/freeradius/3.0/mods-config/sql/main/mysql/schema.sql
```

Provide your radius database user password when prompt and hit Enter to import the database schema. 
Next, you will need to create a symbolic link for sql module. You can do it with the following command: 

```
ln -s /etc/freeradius/3.0/mods-available/sql /etc/freeradius/3.0/mods-enabled/
```

Next, log in to MariaDB shell and check the created tables with the following command: 

```
mysql -u root -p
```

Enter your root password when prompt. Once login, change the database to radiusdb with the following command: 

```
MariaDB [(none)]> use radiusdb;
```

Next, list the created tables using the following command: 

```
MariaDB [radiusdb]> show tables;
```

You should see the following output: 

```
+--------------------+
| Tables_in_radiusdb |
+--------------------+
| nas                |
| radacct            |
| radcheck           |
| radgroupcheck      |
| radgroupreply      |
| radpostauth        |
| radreply           |
| radusergroup       |
+--------------------+
```

Next, exit from the MariaDB shell with the following command: 

```
MariaDB [radiusdb]> EXIT;
```

Next, you will need to define your database connection details in freeradius SQL module. You can do it by editing /etc/freeradius/3.0/mods-enabled/sql file: 

```
nano /etc/freeradius/3.0/mods-enabled/sql
```

Make the following changes as per your database.

```
sql {
driver = "rlm_sql_mysql"
dialect = "mysql"

# Connection info:
server = "localhost"
port = 3306
login = "radius"
password = "password"

# Database table configuration for everything except Oracle
radius_db = "radiusdb"
}

read_clients = yes
client_table = "nas"
```

Save and close the file, when you are finished. Then, change the ownership of /etc/freeradius/3.0/mods-enabled/sql with the following command:

```
chgrp -h freerad /etc/freeradius/3.0/mods-available/sql
chown -R freerad:freerad /etc/freeradius/3.0/mods-enabled/sql
```

Finally, restart freeradius service to apply all the configuration changes: 

```
systemctl restart freeradius
```

You can also verify the freeradius status with the following command: 

```
systemctl status freeradius
```

You should see the following output: 

```
? freeradius.service - FreeRADIUS multi-protocol policy server
   Loaded: loaded (/lib/systemd/system/freeradius.service; disabled; vendor preset: enabled)
   Active: active (running) since Wed 2019-08-07 09:20:34 UTC; 14s ago
     Docs: man:radiusd(8)
           man:radiusd.conf(5)
           http://wiki.freeradius.org/
           http://networkradius.com/doc/
  Process: 45159 ExecStart=/usr/sbin/freeradius $FREERADIUS_OPTIONS (code=exited, status=0/SUCCESS)
  Process: 45143 ExecStartPre=/usr/sbin/freeradius $FREERADIUS_OPTIONS -Cxm -lstdout (code=exited, status=0/SUCCESS)
 Main PID: 45161 (freeradius)
    Tasks: 6 (limit: 4650)
   CGroup: /system.slice/freeradius.service
           ??45161 /usr/sbin/freeradius
```
Once you have finished, you can proceed to the next step. 

## Test your radius server by using below command

radtest username password localhost:1812 1 secret key

```
Ex: radtest qa@amzetta.com password123 localhost:1812 1 testing123
```

## Add users in radius

nano /etc/freeradius/3.0/users
Add into last line like username Cleartext-Password:=Password

```
Ex:  zwanqa@amzetta.com Cleartext-Password :=P@$$w0rd
```
Save it.


## To get secret key
cat /etc/freeradius/3.0/clients.conf
For zwan testing need to put wild-card entry in /etc/freeradius/3.0/clients.conf and restart the server.

```
client private-network-2 {
        ipaddr          = *
        secret          = testing123
}
```

## Reference

https://www.howtoforge.com/how-to-install-freeradius-and-daloradius-on-ubuntu-1804/




