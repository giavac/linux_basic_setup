# linux_basic_setup
Puppet manifests to setup a brand new host quickly

Verified so far on a CentOS 7 host from DigitalOcean

### What these modules do
Change SSH settings:
- Change the listening port
- Disable remote root login

Set up a firewall:
- Allow connections from local
- Allow existing connections
- Allow connections to SSH port
- Drop everything else

Create a default user:
- A default user, 'admin', is created
- 'admin' is sudoer

### To apply
```
sudo puppet apply -v -e "include roles::basic_setup" --modulepath=modules/:/etc/puppet/modules --show_diff --noop
sudo puppet apply -v -e "include roles::basic_setup" --modulepath=modules/:/etc/puppet/modules --show_diff
```
