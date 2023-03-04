# @summary main class to generate postgres passfiles
#
# @param passfiles
#   Hash to create the files, see postgresql_userconfig::passfile
#   for keys to use.
#   in hiera this parameter is hash merged
# @param passfiles_defaults
#   use this if you want any defaults changed for the files.
# @param passfile_entries
#   Hash to create file entries, see postgresql_userconfig::passfile_entry
#   for keys to use.
#   in hiera this parameter is hash merged
# @param passfile_entries_defaults
#   use this if you want any defaults changed for the entries.
#
# @example
#   include postgresql_passfile
class postgresql_userconfig (
  Hash $passfiles            = {},
  Hash $passfiles_defaults   = {},
  Hash $passfile_entries          = {},
  Hash $passfile_entries_defaults = {},
) {
  create_resources(postgresql_userconfig::passfile, $passfiles, $passfiles_defaults)
  create_resources(postgresql_userconfig::passfile_entry, $passfile_entries, $passfile_entries_defaults)
}
