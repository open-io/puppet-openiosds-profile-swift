openiosds::conscience {'conscience-1':
  num            => '1',
  ns             => 'OPENIO',
  conscience_url => "${ipaddress_enp0s8}:6000",
  oioproxy_url   => "${ipaddress_enp0s8}:6006",
  eventagent_url => "tcp://${ipaddress_enp0s8}:6008",
}
