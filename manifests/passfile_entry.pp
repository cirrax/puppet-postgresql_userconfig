# @summary add an entry (line) in one ore more pgpass files
#
# lets you define a line entry in the pgpass file
# for simplification, you can define multiple targets.
#
# @param targets
#  the title of the target passfile. this can also
#  be an array, if you like to add a database to several
#  pgpass files.
# @param comment
#  a simple comment to add to the file prior to the entry
# @param hostname
#  the hostname entry
# @param port
#  the port entry
# @param database
#  the database entry
# @param username
#  the username entry
# @param password
#  the password entry
# @param order
#  the order in the file
#
# @example
#   postgresql_userconfig::passfile_entry { 'namevar': }
#
define postgresql_userconfig::passfile_entry (
  Variant[String, Array] $targets  = [],
  Optional[String]       $comment  = undef,
  String                 $hostname = '*',
  String                 $port     = '5432',
  String                 $database = $title,
  String                 $username = '*',
  Optional[String]       $password = undef,
  String                 $order    = '100',
) {

  if $targets =~ Array {
    $_targets = $targets
  } else {
    $_targets = [ $targets ]
  }

  $_targets.each | String $target | {
    concat::fragment{ "${title} ${target}":
      target  => $target,
      content => template('postgresql_userconfig/passfile_entry.erb'),
      order   => $order,
    }
  }
}
