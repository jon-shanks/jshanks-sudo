##
# Class sudo::entry
#
# Adds a sudo rule entry into a file and places it within sudoers.d
#
# Parameters:
# - $name
# Name of the rule / used in the filename
# - $entry_list
# Hash containing the deails of the sudo entry: comment, userspec, commands, hostlist, users, tagspec etc.
#  sudo::entry_list:
#                 U_DBA:
#                 comment: GDS Team DBA Team
#                 users:
#                    - R_DBA
#                    - R_BO
#                    - DBA2
#                 hostlist:
#                    - PUPPET_SERVERS
#                 tagspec:
#                    - NOPASSWD
#                 commands:
#                    - ALL
#
# Actions
# - Creates the entry into sudo placing it in /etc/sudoers.d/ based on predefined aliases
#
# Sample Usage:
#  sudo::entry { 'sudo_entries': priority => 90, entry_list => {'U_DBA'    =>
#                                                              {'comment'  => 'GDS Team DBA Team',
#                                                               'users'    => '["R_DBA","R_BO","DBA2"]',
#                                                               'hostlist' => '["PUPPET_SERVERS"]',
#                                                               'tagspec'  => '["NOPASSWD"]',
#                                                               'commands' => '["ALL"]'}
#                                                              }
#  }
class sudo::entry($entry_list = {},
                  $priority   = 90)
{

   $file = $name

   file { "/etc/sudoers.d/${priority}-${name}":
      content     => template('sudo/entry.erb'),
      require     => Class['sudo'],
      mode        => '0440',
   }
}
