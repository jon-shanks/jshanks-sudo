#
# == Class: sudo::cmnd_alias
#
# Adds a command alias entry into a file and places it within sudoers.d
#
# == Parameters
# [$name]
# Name of the alias / used in the filename
# [$command_aliases]
# Hash containing the name of the command alias comment and commands example is:
#  sudo::command_aliases:
#                 DDM_SOLARIS_LINUX_CMD:
#                 comment: DDMa / DDMI application commands
#                 commands:
#                    - /usr/bin/which
#                    - /usr/rpm -q *
#                    - !/usr/sbin/pkgchk -f
#
# Actions
# - Creates the command alias in /etc/sudoers.d/
#
# Sample Usage:
#  sudo::cmnd_alias { 'cmnd_aliases': priority => 10, command_aliases => {'DDM_SOLARIX_LINUX_CMD' =>
#                                                                        {'comment' => 'DDMa/DDMI application cmd',
#                                                                         'commands' => '["/usr/bin/which","/bin/ls"]'}
#                                                                         }
#  }
class sudo::cmnd_alias($command_aliases = {}, $priority = 20)
{

  $file = $name

  if $command_aliases and !empty($command_aliases) {
    file { "/etc/sudoers.d/${priority}-${file}":
      content     => template('sudo/commands.erb'),
      require     => Class['sudo'],
      mode        => '0440',
    }
  }
}
