# linux_basic_setup
Puppet manifests to setup a brand new host quickly

Verified so far on a CentOS 7 host from DigitalOcean

### What these modules do
They set up SSH by:
- Changing the listening port
- Disabling remote root login

They set up a firewall:
- Allow connections from local
- Allow existing connections
- Allow connections to SSH port
- Drop everything else

Users:
- A default user, 'admin', is create
- 'admin' is sudoer

### To apply
sudo puppet apply -v -e "include roles::basic_setup" --modulepath=modules/:/etc/puppet/modules --show_diff --noop
sudo puppet apply -v -e "include roles::basic_setup" --modulepath=modules/:/etc/puppet/modules --show_diff
