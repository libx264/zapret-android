iptables -t nat -D OUTPUT -p tcp --dport 53 -j DNAT --to-destination 83.220.169.155:53
iptables -t nat -D OUTPUT -p udp --dport 53 -j DNAT --to-destination 83.220.169.155:53

iptables -t nat -I OUTPUT -p tcp --dport 53 -j DNAT --to-destination 83.220.169.155:53
iptables -t nat -I OUTPUT -p udp --dport 53 -j DNAT --to-destination 83.220.169.155:53

iptables -t mangle -D POSTROUTING -p tcp  -j NFQUEUE --queue-num 200 --queue-bypass
iptables -t mangle -D POSTROUTING -p udp  -j NFQUEUE --queue-num 200 --queue-bypass

iptables -t mangle -I POSTROUTING -p tcp  -j NFQUEUE --queue-num 200 --queue-bypass
iptables -t mangle -I POSTROUTING -p udp  -j NFQUEUE --queue-num 200 --queue-bypass

chmod +x .

./nfqws --uid 1:3003 --qnum 200 --filter-tcp=80 --dpi-desync=fake,fakedsplit --dpi-desync-autottl=2 --dpi-desync-fooling=md5sig --new --filter-tcp=443 --hostlist=list-youtube.txt --dpi-desync=fake,multidisorder --dpi-desync-split-pos=1,midsld --dpi-desync-repeats=11 --dpi-desync-fooling=md5sig --dpi-desync-fake-tls=tls_clienthello_www_google_com.bin --new --filter-tcp=443 --dpi-desync=fake,multidisorder --dpi-desync-split-pos=midsld --dpi-desync-repeats=6 --dpi-desync-fooling=badseq,md5sig --new --filter-udp=443 --hostlist=list-youtube.txt --dpi-desync=fake --dpi-desync-repeats=11 --dpi-desync-fake-quic=quic_initial_www_google_com.bin --new --filter-udp=443 --dpi-desync=fake --dpi-desync-repeats=11 --new --filter-udp=50000-50099 --ipset=ipset-discord.txt --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-any-protocol --dpi-desync-cutoff=n4
