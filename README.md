# flexlm-systemd-service
This is a systemd-based service definition to run FlexLM lmgrd.

_This code is provided “AS IS”. The developer makes no other warranties, express or implied, 
and hereby disclaims all implied warranties, including any warranty of merchantability and 
warranty of fitness for a particular purpose._

Based on the following:
* https://www.schrodinger.com/kb/1148
* https://medium.com/@benmorel/creating-a-linux-service-with-systemd-611b5c8b91d6
* https://gist.github.com/kalebo/fd39edb6c6e4ebed41f7eab2d9925ebc
* https://www.freedesktop.org/software/systemd/man/systemd.unit.html (man page)
* http://0pointer.net/blog/projects/systemd-docs.html
* https://docs.fedoraproject.org/en-US/quick-docs/understanding-and-administering-systemd/

## Unprivileged (System) User flexlm
Create an unprivileged user, e.g. flexlm, to run the service. The following will create the user
with a home directory `/opt/flexlm`:
```bash
useradd flexlm -b /opt -c "FlexLM User" -s /sbin/nologin --create-home --system 
```

## FlexLM Directory Tree
Based in `/opt/flexlm`
* `/opt/flexlm/bin` will contain all executables, except for the vendor daemons. Vendor
daemons are typically named with the vendor name in all capitals, e.g. "INTEL". (Really,
the daemons are just copies of `lmgrd`.
* `/opt/flexlm/licenses` will contain all license files.

Create the directory structure:
```
mkdir -p /opt/flexlm/bin /opt/flexlm/licenses
```

## Install `lmgrd` and Vendor Daemon(s)
The vendor should have provided a copy of the `lmgrd` executable, along with
the vendor daemon, say it is called `FOOBAR`. Copy and create the appropriate links (using the `make_flexlm_links.sh` script):
```
cp lmgrd /opt/flexlm/bin
cp FOOBAR /opt/flexlm/bin
cd /opt/flexlm/bin
make_flexlm_links.sh
```

## Install License Files
Server license files should be plain text with at `.lic` suffix.
```
cp FOO.lic /opt/flexlm/licenses
```

## FlexLM Logging
Log in subdirectory of `/var/log`:
```
mkdir -p /var/log/lmgrd
chown -R flexlm /var/log/lmgrd
chmod -R 0744 /var/log/lmgrd
```

## Install Service Definition File
Copy the `lmgrd.service` file to `/etc/systemd/system/`

## Enable and Start Service
Use `systemctl` to enable and start the service:
```
systemctl enable lmgrd.service
systemctl start lmgrd.service
```

## Client Setup
Users who use the license software usually have a particular environment variable
set which contains the full path to the client license file, which is basically
bare bones except for a line which specifies the license server, and a line 
saying "`USE_SERVER`".
