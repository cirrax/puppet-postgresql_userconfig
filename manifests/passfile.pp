# @summary initialize a passfile
#
# @param filename
#   filename to write
# @param filepath
#   the path to use for the file to write, 
#   normaly the homedirectory of the user.
#   but puppet cannot (yet ?) detect your'e home, 
#   so we make this a parameter
# @param owner
#   owner of the file (defaults to the title)
# @param group
#   group of the file.
# @param mode
#   the mode of the file
# @param filename
#   the path and name of the file to create.
#
# @example
#   postgresql_userconfig::passfile { 'namevar': }
define postgresql_userconfig::passfile (
  String           $filepath,
  String           $filename = '.pgpass',
  String           $owner    = $title,
  Optional[String] $group    = undef,
  String           $mode     = '0600',
) {
  concat{ $title:
    owner => $owner,
    group => $group,
    mode  => $mode,
    path  => "${filepath}/${filename}",
  }

  concat::fragment{"${title} header":
    target  => $title,
    order   => '000',
    content => "# Managed with puppet, do not change\n# Format:hostname:port:database:username:password",
  }
}

