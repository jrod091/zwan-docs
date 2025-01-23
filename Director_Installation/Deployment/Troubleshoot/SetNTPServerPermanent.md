# Steps to Add ntp server permanently in zWAN director VMs Ubuntu

1. Add ntp server IP or domain name in NTP and FallbackNTP 
    
   $ sudo vim /etc/systemd/timesyncd.conf

```
[Time]
   NTP=ntp.edison-bd.com
   #NTP=
   #FallbackNTP=ntp.ubuntu.com
   #RootDistanceMaxSec=5
   #PollIntervalMinSec=32
   #PollIntervalMaxSec=2048
```


2. Reload and restart the timesync service 

   $ sudo systemctl daemon-reload 
   
   $ sudo systemctl restart systemd-timesyncd 
   
   $ sudo systemctl status systemd-timesyncd

```
Sample Output:
 ● systemd-timesyncd.service - Network Time Synchronization
   Loaded: loaded (/lib/systemd/system/systemd-timesyncd.service; enabled; vendor preset: enabled)
   Active: active (running) since Thu 2023-03-30 12:23:02 UTC; 6 days ago
     Docs: man:systemd-timesyncd.service(8)
 Main PID: 613 (systemd-timesyn)
   Status: "Synchronized to time server 185.125.190.58:123 (ntp.ubuntu.com)." 
    Tasks: 2 (limit: 4915)
   CGroup: /system.slice/systemd-timesyncd.service
           └─613 /lib/systemd/systemd-timesyncd
Apr 06 04:47:23 k3s1 systemd-timesyncd[613]: Network configuration changed, trying to establish connection.
 Apr 06 04:47:23 k3s1 systemd-timesyncd[613]: Synchronized to time server 185.125.190.58:123 (ntp.ubuntu.com).
```


3. In timedatectl ouput should be "System clock synchronized: yes"

   $ timedatectl

```
Sample Output:
                       Local time: Thu 2023-04-06 06:46:39 UTC
                  Universal time: Thu 2023-04-06 06:46:39 UTC
                        RTC time: Thu 2023-04-06 06:46:40
                       Time zone: UTC (UTC, +0000)
       System clock synchronized: yes
systemd-timesyncd.service active: yes
                 RTC in local TZ: no
```

