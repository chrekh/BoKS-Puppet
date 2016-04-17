#
# Do you want to automatically start BoKS at each server boot?
# Of course you do! But if you didn't, you can disable it with
# this class.
#

class boks::service inherits boks {
  if $service_manage == "true" {
    service { "${service_name}":
      ensure => $service_ensure,
      enable => $service_enable,
      subscribe => [ File["${bcastaddr_file}"],
                     File["${nodekey_file}"],
                     File["${env_file}"] ],
      require => [ Package["${package_name}"],
                   File["${nodekey_file}"] ],
    }
  }
}
