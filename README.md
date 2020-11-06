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
with a home directory /opt/flexlm:
```bash
useradd flexlm -b /opt -c "FlexLM User" -s /sbin/nologin --create-home --system 
```
