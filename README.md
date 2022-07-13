# auto_compose
A small script to make the containers start automatically after manually mounting the shared volumes.

## Preamble

For security reasons, with Synology devices It'a best practice to set an external USB drive as Key Store Location.
[HERE](https://blog.elcomsoft.com/2019/11/synology-nas-encryption-forensic-analysis-of-synology-nas-devices/) you can find more info about it.

This prevent the user from using the automount feature, so the shared folders need to be mounted manually through the Key Manager.

## Problem to be solved

***After mounting***, the containers that make use of some encrypted shared folders don't start automatically (even if a `restart: always` flag is set in the YML file).

So the user must launche a `docker-compose up` in a CLI, and this could be quite tedious if you're not in the same LAN (VPN needed etc).

This veeery small script is "designed" to solve this problem by running it every X minutes using the Task Scheduler of DSM (I set it to run every 5 minutes).

If the directory `TEST_DIR` has been mounted (I deliberately decided to use `/volume1/homes`), the script compares the list of containers in the YML file with the list of running containers.

If the the two lists don't match, a `docker-compose up` is lauched.

Obviously the user must edit the path for `TEST_DIR` and `DOCKER_DIR` before using the script.

## NOTE

The script is set to use the `container_name` field in the YML file, so every container without that field will "break" the scipt.

Moreover, the script will ignore all commented containers (more precisely, it will ignore every commented line of the YML that starts with one or more `#` **followed by one ore more spaces**).
