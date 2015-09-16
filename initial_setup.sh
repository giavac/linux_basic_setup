#!/usr/bin/sh

SSHD_PORT=" FILL THIS  "
DEFAULT_USER=" FILL THIS "

# This is the shadow
DEFAULT_PASSWORD=' SHADOW PASSWORD HERE '

yum install -y git
yum install -y vim
rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm

yum install -y puppet
puppet module install puppetlabs-firewall
puppet module install saz-sudo

git clone https://github.com/giavac/linux_basic_setup.git
cd linux_basic_setup/

sed -i "s/^profiles::basic_setup::ssh_port:.*$/profiles::basic_setup::ssh_port: ${SSHD_PORT}/" hieradata/common.yaml
sed -i "s/^profiles::basic_setup::default_user:.*$/profiles::basic_setup::default_user: ${DEFAULT_USER}/" hieradata/common.yaml

# This uses the : symbol as separator, because it's not present in the shadow password and doesn't require escaping
echo "s:^profiles\:\:basic_setup\:\:default_pwd\:.*$:profiles\:\:basic_setup\:\:default_pwd\: '${DEFAULT_PASSWORD}':"
sed -i "s:^profiles\:\:basic_setup\:\:default_pwd\:.*$:profiles\:\:basic_setup\:\:default_pwd\: '${DEFAULT_PASSWORD}':" hieradata/common.yaml

puppet apply -v --hiera_config=hiera.yaml -e "include roles::basic_setup" --modulepath=modules/:/etc/puppet/modules --show_diff --noop

# Uncomment to do the real thing
# puppet apply -v --hiera_config=hiera.yaml -e "include roles::basic_setup" --modulepath=modules/:/etc/puppet/modules --show_diff
