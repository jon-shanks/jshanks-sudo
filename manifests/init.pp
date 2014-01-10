##
# Class: sudo
# 
# Manages sudoers
#

class sudo( $u_aliases           = hiera_hash('sudo::user_aliases', {}), 
            $useralias_priority  = 20,
            $c_aliases           = hiera_hash('sudo::command_aliases', {}),
            $command_priority    = 30,
            $default             = hiera_hash('sudo::defaults', {}),
            $defaults_priority   = 10,
            $r_aliases           = hiera_hash('sudo::runas_aliases', {}),
            $runas_priority      = 40,
            $h_aliases           = hiera_hash('sudo::host_aliases', {}),
            $host_priority       = 50,
            $entry               = hiera_hash('sudo::entry_list', {}),
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
