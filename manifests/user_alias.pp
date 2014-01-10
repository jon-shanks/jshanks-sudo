##
# Class sudo::user_alias
#
# Adds a user alias entry into a file and places it within sudoers.d
#
# Parameters:
# - $name
# Name of the alias / used in the filename
# - $user_aliases
# Hash containing the name of the user alias comment and users example is:
#  sudo::user_aliases:
#                 DICK_AND_DOM:
#                   comment: User alias for dick and dom for application x
#                   users:
#                     - dick
#                     - dom
#                     - %somegroup
#
# Actions
# - Creates the user alias in /etc/sudoers.d/
#
# Sample Usage:
#  sudo::user_alias { 'user_aliases': priority => 20, user_aliases => {'DICK_AND_DOM' => 
#                                                                     { 'comment'    => 'user alias for dick and dom',
#                                                                       'alias'       => 'DICK_AND_DOM',
#                                                                       'users'       => '["dick","dom","%somegroup"]} }
#
class sudo::user_alias($user_aliases   = {},
                       $priority       = 20)
{

   $file = $name

   file { "/etc/sudoers.d/${priority}-${file}":
      content     => template('sudo/users.erb'),
      require     => Class['sudo'],
      mode        => '0440',
   }
}

