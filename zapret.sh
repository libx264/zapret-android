#iptables -t nat -D OUTPUT -p tcp --dport 53 -j DNAT --to-destination 83.220.169.155:53
#iptables -t nat -D OUTPUT -p udp --dport 53 -j DNAT --to-destination 83.220.169.155:53

#iptables -t nat -I OUTPUT -p tcp --dport 53 -j DNAT --to-destination 83.220.169.155:53
#iptables -t nat -I OUTPUT -p udp --dport 53 -j DNAT --to-destination 83.220.169.155:53

iptables -t mangle -D POSTROUTING -p tcp  -j NFQUEUE --queue-num 200 --queue-bypass
iptables -t mangle -D POSTROUTING -p udp  -j NFQUEUE --queue-num 200 --queue-bypass

iptables -t mangle -I POSTROUTING -p tcp  -j NFQUEUE --queue-num 200 --queue-bypass
iptables -t mangle -I POSTROUTING -p udp  -j NFQUEUE --queue-num 200 --queue-bypass

chmod 755 .
chmod 655 ./*
chmod +x .
chmod +x ./*

./nfqws --uid 1:3003 --qnum 200 --filter-udp=443 --dpi-desync=fake --dpi-desync-repeats=8 --dpi-desync-fake-quic=quic_initial_www_google_com.bin --new \
--filter-udp=50000-50100 --filter-l7=discord,stun --dpi-desync=fake --dpi-desync-repeats=6 --new \
--filter-tcp=80 --dpi-desync=fake,split2 --dpi-desync-autottl=3 --dpi-desync-fooling=md5sig --new \
--filter-tcp=443 --dpi-desync=fake --dpi-desync-ttl=4 --dpi-desync-fake-tls-mod=rnd,rndsni,padencap
