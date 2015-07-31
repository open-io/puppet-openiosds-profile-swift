openiosds::sdsagent {'sds-agent-0':
}
openiosds::namespace {'OPENIO':
  ns => 'OPENIO',
  conscience_url => "${ipaddress}:6000",
  oioproxy_url   => "${ipaddress}:6006",
  eventagent_url => "tcp://${ipaddress}:6008",
}
openiosds::account {'account-1':
  num => '1',
  ns => 'OPENIO',
  redis_host => '127.0.0.1',
  redis_port => '6379',
}
openiosds::conscience {'conscience-1':
  num            => '1',
  ns             => 'OPENIO',
}
class { 'keystone':
  verbose        => True,
  admin_token    => 'KEYSTONE_ADMIN_UUID',
  database_connection => 'sqlite:////var/lib/keystone/keystone.db',
}

# Adds the admin credential to keystone.
class { 'keystone::roles::admin':
  email        => 'test@openio.io',
  password     => 'ADMIN_PASS',
}

# Installs the service user endpoint.
class { 'keystone::endpoint':
  public_url   => "http://${ipaddress_enp0s8}:5000/v2.0",
  admin_url    => "http://${ipaddress}:5000/v2.0",
  internal_url => "http://${ipaddress}:35357/v2.0",
  region       => 'localhost-1',
}

# Swift
keystone_user { 'swift':
  ensure  => present,
  enabled => True,
  password => 'SWIFT_PASS',
}
keystone_user_role { 'swift@services':
  roles  => ['admin'],
  ensure => present
}
keystone_service { 'openio-swift':
  ensure      => present,
  type        => 'object-store',
  description => 'OpenIO SDS swift proxy',
}
keystone_endpoint { 'localhost-1/openio-swift':
   ensure       => present,
   public_url   => "http://${ipaddress_enp0s8}:6007/v1.0/AUTH_%(tenant_id)s",
   admin_url    => "http://${ipaddress}:6007/v1.0/AUTH_%(tenant_id)s",
   internal_url => "http://${ipaddress}:6007/v1.0/AUTH_%(tenant_id)s",
}

# Demo account
keystone_tenant { 'demo':
  ensure  => present,
  enabled => True,
}
keystone_user { 'demo':
  ensure  => present,
  enabled => True,
  password => "DEMO_PASS",
}
keystone_role { '_member_':
  ensure => present,
}
keystone_user_role { 'demo@demo':
  roles  => ['admin','_member_'],
  ensure => present
}
openiosds::meta0 {'meta0-1':
  num => '1',
  ns => 'OPENIO',
}
openiosds::meta1 {'meta1-1':
  num => '1',
  ns => 'OPENIO',
}
openiosds::meta2 {'meta2-1':
  num => '1',
  ns => 'OPENIO',
}
openiosds::oioeventagent {'oio-event-agent-1':
  num => '1',
  ns => 'OPENIO',
}
openiosds::oioproxy {'oioproxy-1':
  num => '1',
  ns => 'OPENIO',
  ipaddress => '0.0.0.0',
}
openiosds::oioswift {'oioswift-1':
  num => '1',
  ns => 'OPENIO',
  ipaddress => '0.0.0.0',
}
openiosds::rawx {'rawx-1':
  num => '1',
  ns => 'OPENIO',
}
