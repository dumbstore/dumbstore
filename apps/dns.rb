class Dns < Dumbstore::App
  name 'DNS Servers'
  author 'David Huerta'
  author_url 'http://www.davidhuerta.me'
  description <<-DESCRIPTION
  Provides a random public DNS server IP address, 
  in case if you're somewhere where DNS is being 
  used for internet censorship.
  DESCRIPTION
  text_id 'dns'
  
  def text params
    servers = ['censurfridns.dk: 89.233.43.71, 89.104.194.142',
      'Comodo Secure DNS: 8.26.56.26, 8.20.247.20',
      'DNS Advantage: 156.154.70.1, 156.154.71.1',
      'Dyn: 216.146.35.35, 216.146.36.36',
      'FreeDNS: 37.235.1.174, 37.235.1.177',
      'Google Public DNS: 8.8.8.8, 8.8.4.4',
      'Norton DNS: 198.153.192.1, 198.153.194.1',
      'OpenDNS: 208.67.222.222, 208.67.220.220',
      'puntCAT: 109.69.8.51',
      'SmartViper: 208.76.50.50, 208.76.51.51'].shuffle!
    
    "<Response><Sms>#{servers.first}</Sms></Response>"
  end
end