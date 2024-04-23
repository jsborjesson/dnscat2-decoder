# Add dnscat2 to load path
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "dnscat2", "server"))

# Load relevant classes from dnscat2
require "libs/dnser"
require "tunnel_drivers/driver_dns"
require "controller/packet"

DOMAIN = ARGV[0]

def parse(query)
  bytes = [query.gsub(DOMAIN, "").gsub(".", "")].pack("H*")
  Packet.parse(bytes, 0)
end

def display_packet(p)
  case p.type
  when Packet::MESSAGE_TYPE_SYN
    puts p.body.name
  when Packet::MESSAGE_TYPE_MSG
    print p.body.data
  else
    # puts p
  end
end

# Keep track of retransmissions
require "set"
packet_ids = Set.new

STDIN.each_line do |q|
  data = q.strip

  next if data.length < 5
  p = parse(data)

  next if packet_ids.include?(p.packet_id)
  packet_ids.add(p.packet_id)

  display_packet(p)
end
