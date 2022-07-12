# auto_compose
A small script to make the containers start automatically after manually mounting the shared volumes

## Why should I use this script?
For security reasons, with Synology devices It'a best practice to set an external USB drive as Key Store Location.
[HERE](https://blog.elcomsoft.com/2019/11/synology-nas-encryption-forensic-analysis-of-synology-nas-devices/) you can find more info about it.

This prevent the user from using the automount feature, so the shared folders need to be mounted manually through the Key Manager.

**After mounting**, the containers that make use of some encrypted shared folder don't start automatically.

This script is projected to be used with the Task Scheduler of DSM and run every X minutes (I set it every 5 minutes).

If the directory `DIR` has been mounted (I deliberately decided to use the `/volume1/homes`), the script compares the list of containers in the YML files with the list of running containers.

If the the two lists don't match, a `docker-compose up` is lauched.

## NOTE
The script is set to use the `container_name` field in the YML file, so every container without that field will "break" the scipt.

Moreover, the script will ignore all commented container (more precisely, will ignore every commented line that starts with one or more `#` followed by one ore more spaces).
