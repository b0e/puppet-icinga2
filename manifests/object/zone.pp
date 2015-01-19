# == Defined type: icinga2::object::zone
#
# This is a defined type for Icinga 2 apply objects that create Zone
# See the following Icinga 2 doc page for more info:
# http://docs.icinga.org/icinga2/latest/doc/module/icinga2/chapter/configuring-icinga2#objecttype-zone
#
# === Parameters
#
# See the inline comments.
#

define icinga2::object::zone (
  $ensure                    = 'file',
  $object_name               = $name,
  $endpoints                 = undef,
  $parent                    = undef,
  $target_dir                = '/etc/icinga2/objects/zones',
  $target_file_name          = "${name}.conf",
  $target_file_owner         = 'root',
  $target_file_group         = 'root',
  $target_file_mode          = '0644'
) {

  if $parent {
    validate_string($parent)
  }
  validate_array($endpoints)

  file {"${target_dir}/${target_file_name}":
    ensure  => $ensure,
    owner   => $target_file_owner,
    group   => $target_file_group,
    mode    => $target_file_mode,
    content => template('icinga2/object_zone.conf.erb'),
    notify  => Service['icinga2'],
  }
}
