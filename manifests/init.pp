# Public: installs java jre-7u45
#
# Examples
#
#    include java
class java {
  include boxen::config

  $jre_version = '7u45'
  $jdk_version = '7u45'
  $jdk_build_number = '18'

  $jre_dmg_location = "${boxen::config::home}/repo/.tmp/jre.dmg"
  $jdk_dmg_location = "${boxen::config::home}/repo/.tmp/jdk.dmg"

  $wrapper = "${boxen::config::bindir}/java"

  exec { 'download-jre':
    command   => "/usr/bin/curl -o ${jre_dmg_location} -C -k -L -s --header 'Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F;' http://download.oracle.com/otn-pub/java/jdk/${jdk_version}-b${jdk_build_number}/jre-${jre_version}-macosx-x64.dmg",
    creates   => $jre_dmg_location,
  }

  exec { 'download-jdk':
    command   => "/usr/bin/curl -o ${jdk_dmg_location} -C -k -L -s --header 'Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F;' http://download.oracle.com/otn-pub/java/jdk/${jdk_version}-b${jdk_build_number}/jdk-${jdk_version}-macosx-x64.dmg",
    creates   => $jdk_dmg_location,
  }


  package {
    'jre.dmg':
      ensure   => present,
      alias    => 'java-jre',
      provider => pkgdmg,
      source   => $jre_dmg_location ;
    'jdk.dmg':
      ensure   => present,
      alias    => 'java',
      provider => pkgdmg,
      source   => $jdk_dmg_location ;
  }

  file { $wrapper:
    source  => 'puppet:///modules/java/java.sh',
    mode    => '0755',
    require => Package['java']
  }
}
