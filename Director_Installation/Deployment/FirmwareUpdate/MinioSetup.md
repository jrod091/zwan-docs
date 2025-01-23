# **Firmware update with Minio**

1. Login to minio console page https://\<domain-name>/minioconsole/login

   `Username: minioconsole`

   `Password: minioconsole`

| ![](images/minio_login.png) |
| --------------------------- |

| ![](images/minio_buckets.png) |
| ----------------------------- |

2. Create your new bucket using “Create Bucket” button.

| ![](images/create_bucket.png) |
| ----------------------------- |

3. Click on “Buckets” and get the list of buckets.

| ![](images/list_buckets.png) |
| ---------------------------- |

4. Click “Manage” button. Click edit icon in “Access Policy” and change the access policy of you bucket to “Public”

| ![](images/manage_access_policy.png) |
| ------------------------------------ |

5. Upload your firmware update file to your bucket by clicking “upload” button.

| ![](images/upload_file_screen1.png) |
| ----------------------------------- |

| ![](images/upload_file_screen2.png) |
| ----------------------------------- |

6.  The uploaded firmware update file, downloaded link from minio object store should be in the following format,

    `https://<domain-name>:7080/minio/<bucket-name>/<filename>`

    `example:`

        `https://10.200.4.234:7080/minio/zwanfw/cpe-fw-package-1.0-12.1020-3507-from-1.0-12.1021-3533-Jul04-2022-185503.bin`

7.  Create the “manifest.json” file for the specific firmware version as follows,

| ![](images/manifest_json.png) |
| ----------------------------- |

## **manifest.json content details:**

| Field      | Meaning                                                              |
| -------    | ----------------------------------------------------------------     |
| model      | CPE or bananapi model number                                         |
| version    | Lastest firmware version to be updated                               |
| images     | List of firmware update links                                        |
| from       | Current version of firmware in CPE                                   |
| to         | Lastest version of firmware to be updated in CPE                     |
| path       | Firmware update patch download path                                  |
| tenantName | (Optional) Name of the tenant to make firmware update tenant specific|

8. Upload the manifest.json to the same path, where the firmware update file was uploaded.

| ![](images/manifest_upload.png) |
| ------------------------------- |

9.  Download path of manifest.json from the minio object store can be formed as follows,

    `https://<domain-name>:7080/minio/<bucket-name>/<filename>`

    `example:`

        `https://10.200.4.234:7080/minio/zwanfw/manifest.json`

10. Login to MSP page https://<domain-name>:7080 and select “Firmware” tab.

| ![](images/firmware_tab.png) |
| ---------------------------- |

11. Click “ADD FIRMWARE” button. Copy and past the manifest.json URL link to “Add Firmware” window. Press validate button and press “ADD” button.

| ![](images/add_firmware.png) |
| ---------------------------- |

| ![](images/firmware_added.png) |
| ------------------------------ |

12. Login to the director page. https://<domain-name>:8443/<tenant-name>

| ![](images/provider_login.png) |
| ------------------------------ |

13. Click “Firmware Update” option. In this page following CPE / bananapi details can be viewed.

| CPE / Bananapi Details |
| ---------------------- |
| name                   |
| Model                  |
| Current Version        |
| Target Version         |
| Status                 |
| Retry                  |
| Message                |

14. Verify your “Current Version” of the firmware present in the CPE / bananapi board. In “Target Version”, it should show the version specified in the manifest.json file.

| ![](images/new_firmware_version.png) |
| ------------------------------------ |

15. Click on “Update” button to start update to the latest version of firmware. Watch the update status in “Messages” section.

| ![](images/update_firmware.png) |
| ------------------------------- |

16. After clicking “Update” button, “Update Firmware” dialogue box will be prompted for conformation. Verify the firmware versions and click “Yes”.

| ![](images/confirm_update_firmware.png) |
| --------------------------------------- |

## **Download Started State:**

| ![](images/firmware_downloading.png) |
| ------------------------------------ |

## **Update Started State:**

| ![](images/firmware_update_started.png) |
| --------------------------------------- |

## **Update Completed:**

| ![](images/firmware_update_completed.png) |
| ----------------------------------------- |

17. Check “Current Version” and “Target Version” are same after update “Status” is “Success”.
