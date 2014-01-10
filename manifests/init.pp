##
# == Class: sudo
#  
#  Responsible for managing the sudoers, using the module_hiera_hash custom functions to merge data within modules
#  as well as throughout the hierarchy.
#  
# == Parameters
# [*u_aliases*]
#  A hash of all the user aliases
#
# [*useralias_priority*]
#  User alias file priority, by default its 20
#
# [*c_aliases*]
#  A hash of all the command aliases
#
# [*command_priority*]
#  Command file priority, by default its 30
#
# [*default*]
#  A hash of defaults i.e. !requiretty
#
# [*default_priority*]
#  Default file priority, by default it's 10
#
# [*r_aliases*]
#  Hash of all the runas aliases
#
# [*runas_priority*]
#  Run as priority for the runas file, by default it's 40
#
# [*h_aliases*]
#  A hash of host alias entries
#
# [*host_priority*]
#  The priority of the host file, by default it's 50
#
# [*entry*]
#  The hash contain sudo entries based on users / host aliases / groups etc.
#
# [*entry_priority*]
#  The priority of the entry file, by default its 90
#
# == Example
#

class sudo( $u_aliases           = module_hiera_hash('sudo::user_aliases', {}), 
            $useralias_priority  = 20,
            $c_aliases           = module_hiera_hash('sudo::command_aliases', {}),
            $command_priority    = 30,
            $default             = module_hiera_hash('sudo::defaults', {}),
            $defaults_priority   = 10,
            $r_aliases           = module_hiera_hash('sudo::runas_aliases', {}),
            $runas_priority      = 40,
            $h_aliases           = module_hiera_hash('sudo::host_aliases', {}),
            $host_priority       = 50,
            $entry               = module_hiera_hash('sudo::entry_list', {}),
            $entry_priority      = 90,
          )
      {

  package { 'sudo': 
    ensure   => present,
  }

  file { '/etc/sudoers.d':
    ensure      => directory,
    mode        => '0550',
    purge       => true,
    recurse     => true,
  }

  file { '/etc/sudoers':
    ensure   => present,
    owner    => root,
    group    => root,
    source   => 'puppet:///modules/sudo/sudoers',
    require  => [ File['/etc/sudoers.d'], Package['sudo'] ],
    mode     => '0440',
  }

  class { 'sudo::user_alias':
    name              => 'user_aliases',
    user_aliases      => $u_aliases,
    priority          => $useralias_priority,
  }

  class { 'sudo::cmnd_alias':
    name              => 'command_aliases',
    command_aliases   => $c_aliases,
    priority          => $command_priority,
  }

  class { 'sudo::defaults':
    name              => 'defaults',
    defaults          => $default,
    priority          => $defaults_priority,
  }

  class { 'sudo::runas_alias':
    name              => 'runas_aliases',
    runas_aliases     => $r_aliases,
    priority          => $runas_priority,
  }

  class { 'sudo::host_alias':
    name              => 'host_aliases',
    host_aliases      => $h_aliases,
    priority          => $host_priority,
  }

  class { 'sudo::entry':
    name              => 'sudo_entries',
    entry_list        => $entry,
    priority          => $entry_priority,
  }
}
