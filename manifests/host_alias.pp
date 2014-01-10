##
# Class sudo::host_alias
#
# Adds a command alias entry into a file and places it within sudoers.d
#
# Parameters:
# - $name
# Name of the alias / used in the filename
# - $host_aliases
# Hash containing the name of the host alias comment and hosts example is:
#  sudo::host_aliases:
#                 PUPPET_SERVERS:
#                   comment: list of puppet server hosts
#                   hosts:
#                     - pb2svppt01v.europe.nyx.com
#                     - pb2svppt02v.europe.nyx.com
#                     - pb2svppt03v.europe.nyx.com
#
# Actions
# - Creates the host alias in /etc/sudoers.d/
#
# Sample Usage:
#  sudo::host_alias { 'host_aliases': priority => 40, host_aliases => {'PUPPET_SERVERS' =>
#                                                                     { 'comment'      => 'list of puppet servers',
#                                                                       'hosts'        => '["pb2svppt01","pb2svppt02"]}
#                                                                      }
#  }
#
class sudo::host_alias($host_aliases = {},
                       $priority = 40)
{

   $file = $name

   file { "/etc/sudoers.d/${priority}-${name}":
      content     => template('sudo/hosts.erb'),
      require     => Class['sudo'],
      mode        => '0440',
   }
}

