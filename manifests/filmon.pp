#
# BoKS has its own file monitoring mechanism on board, kind of
# like the classic Tripwire. By default filmon is turned off
# as it may be an unwanted stress on your system. If you so
# desire, you may turn it on and configure it.
#
# The required configuration file is in the templates directory
# and may be further tuned to your liking.
#

class boks::filmon
(
$filmon_set_to = 'off',
$filmon_runhours = '22-06',
$filmon_slowdown = '10',
$filmon_filesystems = '',
)
inherits boks
{
  file_line { 'filmon':
    ensure  => 'present',
    path    => $boks::params::env_file,
    line    => "FILMON=${filmon_set_to}",
    match   => '^FILMON\=',
    require => Package[$boks::params::package_name],
    notify  => Service['boksm'],
  }

  file { "${boks::params::boks_etc}/filmon.conf":
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    require => Package[$boks::params::package_name],
    content => template('boks/filmon.erb'),
  }

  file_line { 'filmon_runhours':
    ensure  => 'present',
    path    => "${boks::params::boks_etc}/filmon.conf",
    line    => "runhours ${filmon_runhours}",
    match   => 'runhours ',
    require => File["${boks::params::boks_etc}/filmon.conf"],
  }

  file_line { 'filmon_slowdown':
    ensure  => 'present',
    path    => "${boks::params::boks_etc}/filmon.conf",
    line    => "slowdown ${filmon_slowdown}",
    match   => 'slowdown ',
    require => File["${boks::params::boks_etc}/filmon.conf"],
  }

  file_line { 'filmon_filesystems':
    ensure  => 'present',
    path    => "${boks::params::boks_etc}/filmon.conf",
    line    => "filesystems ${filmon_runhours}",
    match   => 'filesystems ',
    require => File["${boks::params::boks_etc}/filmon.conf"],
  }

}
