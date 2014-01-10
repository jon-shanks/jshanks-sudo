##
# Class: sudo::defaults
#
# Adds a default entry to the sudoers.d directory
#
# Parameters:
# - $name
#
# - $flags
#
# - $priority
#
# Actions:
# - Creates defaults entry in sudoers.d
#
# Sample Usage:
#   sudo::defaults { 'disable requiretty': }
#


class sudo::defaults( $defaults = {},
                      $priority = 10 )
{

  $file = $name

  if $defaults and !empty($defaults) {
    file { "/etc/sudoers.d/${priority}-${file}":
      content     => template('sudo/defaults.erb'),
      mode        => '0440',
      require     => Class['sudo'],
    } 
  }
}
