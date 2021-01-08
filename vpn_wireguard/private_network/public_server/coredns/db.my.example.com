; my.example.com
$TTL 3600
my.example.com. IN     SOA    ns1.my.example.com. dnsmaster.my.example.com. (
                            2020060601  ; Serial
                            3H          ; refresh after 3 hours
                            1H          ; retry after 1 hour
                            1W          ; expire after 1 week
                            1D)         ; minimum TTL of 1 day

; Name Server - NS records
@      IN       NS      ns1.my.example.com.

; Name Server - A records
; set dns server to vpn address of host (public server address set in ../wg_conf/wg0.conf)
ns1.my.example.com     IN A            10.0.0.1

; A records - set private domain ip address and subdomains - accessible only through vpn
; set ip address to the traefik container ip address on client docker network called vpn (set in traefik_server_private/docker-compose.yml)
my.example.com.        IN A            172.11.12.3
www                    IN CNAME        172.11.12.3
*                      IN A            172.11.12.3

; Reverse records
0.0.10.in-addr.arpa.    IN PTR        my.example.com.
