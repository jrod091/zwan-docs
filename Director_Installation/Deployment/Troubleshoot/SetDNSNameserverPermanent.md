# Adding nameserver in resolv.conf of zWAN Director VMs ubuntu permanently:

1. **Install resolvconf apt package**

	$ sudo apt install resolvconf

2. **Open /etc/resolvconf/resolv.conf.d/head**

   	$ cd /etc/resolvconf/resolv.conf.d
   	
   **Backup head file**
   
   	$ sudo cp -p head head.orig
   	
   **Edit head file**
   
   	$sudo nano head
   	
3. **Add needed nameserver entry in "head" file**

	nameserver <ip_of_nameserver>
	
	example: nameserver 8.8.8.8
	
4. **Update resolvconf**

	$ sudo resolvconf -u
	
5. **Verify nameserver entry added in /etc/resolv.conf**

	$ cat /etc/resolv.conf
	
6. **Check DNS resolve proper with needed domain names.**

   	example: ping google.com
