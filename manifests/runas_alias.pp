##
# Class sudo::runas_alias
#
# Adds a command alias entry into a file and places it within sudoers.d
#
# Parameters:
# - $name
# Name of the alias / used in the filename
# - $runas_alias
# Hash containing the name of the runas alias comment and users example is:
#  sudo::runas_alias:
#                 DDM_PROBE:
#                 comment: DDMa / DDMI runas list
#                 users:
#                    - %group
#                    - user1
#                    - user2
#
# Actions
# - Creates the Runas alias in /etc/sudoers.d/
#
# Sample Usage:
#  sudo::runas_alias { 'runas_alias': priority => 40, runas_aliases => {'DDM_PROBE' =>
#                                                                      {'comment' => 'DDMA/I runas list'
#                                                                       'users'    => '["%group","user1","user2"]' }
#                                                                       }
#  }
#
class sudo::runas_alias($runas_aliases = {},
                        $priority = 40)
{

  $file = $name

  if $runas_aliases and !empty($runas_aliases) {
    file { "/etc/sudoers.d/${priority}-${name}":
      content     => template('sudo/runas.erb'),
      require     => Class['sudo'],
      mode        => '0440',
    }
  }
}
