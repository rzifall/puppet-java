# Public: installs java jre-7u45
#
# Examples
#
#    include java
class java {
  include boxen::config

  $jre_url = 'http://download.oracle.com/otn-pub/java/jdk/7u45-b18/jre-7u45-macosx-x64.dmg'
  $jdk_url = 'http://download.oracle.com/otn-pub/java/jdk/7u45-b18/jdk-7u45-macosx-x64.dmg'
  $wrapper = "${boxen::config::bindir}/java"

  package {
    'jre-7u45.dmg':
      ensure   => present,
      alias    => 'java-jre',
      provider => pkgdmg,
      source   => $jre_url ;
    'jdk-7u45.dmg':
      ensure   => present,
      alias    => 'java',
      provider => pkgdmg,
      source   => $jdk_url ;
  }

  file { $wrapper:
    source  => 'puppet:///modules/java/java.sh',
    mode    => '0755',
    require => Package['java']
  }
}
