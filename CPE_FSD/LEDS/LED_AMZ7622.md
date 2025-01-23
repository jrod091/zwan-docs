| S.NO                                 | LED                        | LED                                  | Remarks                                                     |
| ------------------------------------ | -------------------------- | ------------------------------------ | ----------------------------------------------------------- |
| 1                                    | BOOT_PROCESS               | CPE Status LED: Blink Green and Blue | Booting System - Initrd state - 3 Blinks<br> followed by contineous blinks during boot process until MgmtTunnel service |
| 2                                    | BOOT_FAIL                  | CPE Status LED: On Red               | Booting failed in UBOOT or Initrd                           |
| 3                                    | PROVISION_DONE             | CPE Status LED: On Green             | After Boot - CPE Provisioned  (MgmtTunnel service)                              |
| 4                                    | PROVISION_PENDING          | CPE Status LED: Blink Green          | After Boot - CPE UnProvisioned (MgmtTunnel service)                          |
| After Provision
| 5                                    | MGMT_TUNNEL_RECONNECTING   | CPE Status LED: Blink Blue           | MgmtTunnel service                                                             |
| 6                                    | MGMT_TUNNEL_CONNECTED      | CPE Status LED: Off Blue             | MgmtTunnel service                                                             |
| 7                                    | RECOVERY_BOOT              | CPE Status LED: Blink Red            | Booting to Recovery - From Initrd - 3 Blinks<br> followed by one of the following two states            |
| 8                                    | RECOVERY_FACTORY_RESET     | CPE Status LED: Blink Red and Blue   | Booted to Recovery -  performing factory reset operation    |
| 9                                    | RECOVERY_FW_UPDATE         | CPE Status LED: Blink Red and Green  | Booted to Recovery -  performing patch update/recovery to last good image |
| 10                                   | WAN00_UP                   | WAN00  LED On                        |                                                             |
| 11                                   | WAN00_DOWN                 | WAN00 LED Off                        |                                                             |
| 12                                   | WAN01_UP                   | WAN01 LED On                         |                                                             |
| 13                                   | WAN01_DOWN                 | WAN01 LED Off                        |                                                             |
| 14                                   | LAN00_UP                   | LAN00 LED On                         |                                                             |
| 15                                   | LAN00_DOWN                 | LAN00 LED Off                        |                                                             |
| 16                                   | LAN01_UP                   | LAN01 LED On                         |                                                             |
| 17                                   | LAN01_DOWN                 | LAN01 LED Off                        |                                                             |
| 18                                   | LAN02_UP                   | LAN02 LED On                         |                                                             |
| 19                                   | LAN02_DOWN                 | LAN02 LED Off                        |                                                             |
| 20                                   | LAN03_UP                   | LAN03 LED On                         |                                                             |
| 21                                   | LAN03_DOWN                 | LAN03 LED Off                        |                                                             |
| 22                                   | LTE0_UP                    | LTE0 LED ON                          |                                                             |
| 23                                   | LTE0_DOWN                  | LTE0 LED Blink                       |                                                             |
| 24                                   | LTE0_SIM_MISSING           | LTE0 LED Off                         |                                                             |
| 25                                   | LTE1_UP                    | LTE1 LED ON                          |                                                             |
| 26                                   | LTE1_DOWN                  | LTE1 LED Blink                       |                                                             |
| 27                                   | LTE1_SIM_MISSING           | LTE1 LED Off                         |                                                             |
| 28                                   | 5G_UP                      | 5G LED ON                            |                                                             |
| 29                                   | 5G_DOWN                    | 5G LED Blink                         |                                                             |
| 30                                   | 5G_SIM_MISSING             | 5G LED Off                           |                                                             |
| 31                                   | LAN05_UP ( WIFI AP Mode)   | Wifi LED On                          |                                                             |
| 32                                   | LAN05_DOWN ( WIFI AP Mode) | Wifi LED Off                         |                                                             |
| 33                                   | GEO_FENCE                  | CPE Status LED: On RED                  |                                                             |
