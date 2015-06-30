openiosds::conscience {'conscience-1':
  num            => '1',
  ns             => 'OPENIO',
  conscience_url => "${ipaddress}:6000",
  oioproxy_url   => "${ipaddress}:6006",
  eventagent_url => "tcp://${ipaddress}:6008",
}
