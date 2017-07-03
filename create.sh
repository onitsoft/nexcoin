#!/usr/bin/env bash

#Script parameters
: ${COINNAME:="SourceCoin"} #NexchangeCoin
LOWERNAME=${COINNAME,,} #nexchangecoin
UPPERNAME=${COINNAME^^} #NEXCHANGECOIN
: ${COINCODE:="SRC"} #XNE
: ${REGULARPORT:='1111'} #8228
: ${TESTNETPORT:='11111'} #18228
: ${RPCPORT:='2222'} #8229
: ${TESTNETRPCPORT:='22222'} #18229
: ${VERMAJ:='1'} #1
: ${VERMIN:='0'} #0
: ${VERREV:='0'} #0
: ${VERBUI:='0'} #0
: ${ADDRVER:='0'} #53
: ${ALERTPUB:="0486bce1bac0d543f104cbff2bd23680056a3b9ea05e1137d2ff90eeb5e08472eb500322593a2cb06fbf8297d7beb6cd30cb90f98153b5b7cce1493749e41e0284"} #04088d3cdb8e76a602e7f0e2b7f77ebf066d7385866a704de187a769e3108bf6ee4d98a5eb90f7656c006c5bdbb4d8b7c096dfa3c7019b52cc18db3121e6f43e9b
: ${HEADLINE:="20 Oct 2015 A Bloomberg Run? Drums Are Beating"} #24 May 2017 Coindesk Bitcoin's New Scaling 'Agreement': The Reaction
: ${GENTIMESTAMP:="1445353519"} #1495660200
: ${GENNONCE:="61618576"} #3145601
: ${GENHASH:="0x000001768b08da66b92dede0ea8e7dcb97424f93d7ac2ac59e7a6cf98f20615a"} #000001408d77cac3e6cf652e75c7235d8656ccdd7f0abfa794f9f70e0dd11149
: ${MERKLEHASH:="0x2da7a0080141ea1b6e32f670af4461801b638ba867241d319c3d590d03d75614"} #74f33e577d20398687e891958df0f9aeb0bb5e0650481df6c1b8a7730d910949
: ${STAKEMINAGE:='1'} #1
: ${LASTPOW:='1300'} #6
: ${POWREWARD:='100000'} #100000

echo "Creating $COINNAME source..." 

grep -rIl 'NexchangeCoin' ./ | xargs sed -i "s|NexchangeCoin|$COINNAME|g; "
grep -rIl 'nexchangecoin' ./ | xargs sed -i "s|nexchangecoin|$LOWERNAME|g; "
grep -rIl 'NEXCHANGECOIN' ./ | xargs sed -i "s|NEXCHANGECOIN|$UPPERNAME|g; "
grep -rIl 'XNE' ./ | xargs sed -i "s|XNE|$COINCODE|g; "
grep -rIl '18228' ./ | xargs sed -i "s|18228|$TESTNETPORT|g; "
grep -rIl '8228' ./ | xargs sed -i "s|8228|$REGULARPORT|g; "
grep -rIl '18229' ./ | xargs sed -i "s|18229|$TESTNETRPCPORT|g; "
grep -rIl '8229' ./ | xargs sed -i "s|8229|$RPCPORT|g; "
grep -rIl '1' ./ | xargs sed -i "s|1|$VERMAJ|g; "
grep -rIl '0' ./ | xargs sed -i "s|0|$VERMIN|g; "
grep -rIl '0' ./ | xargs sed -i "s|0|$VERREV|g; "
grep -rIl '0' ./ | xargs sed -i "s|0|$VERBUI|g; "
grep -rIl '53' ./ | xargs sed -i "s|53|$ADDRVER|g; "
grep -rIl '04088d3cdb8e76a602e7f0e2b7f77ebf066d7385866a704de187a769e3108bf6ee4d98a5eb90f7656c006c5bdbb4d8b7c096dfa3c7019b52cc18db3121e6f43e9b' ./ | xargs sed -i "s|04088d3cdb8e76a602e7f0e2b7f77ebf066d7385866a704de187a769e3108bf6ee4d98a5eb90f7656c006c5bdbb4d8b7c096dfa3c7019b52cc18db3121e6f43e9b|$ALERTPUB|g; "
grep -rIl '24 May 2017 Coindesk Bitcoin's New Scaling 'Agreement': The Reaction' ./ | xargs sed -i "s|24 May 2017 Coindesk Bitcoin's New Scaling 'Agreement': The Reaction|$HEADLINE|g; "
grep -rIl '1495660200' ./ | xargs sed -i "s|1495660200|$GENTIMESTAMP|g; "
grep -rIl '3145601' ./ | xargs sed -i "s|3145601|$GENNONCE|g; "
grep -rIl '000001408d77cac3e6cf652e75c7235d8656ccdd7f0abfa794f9f70e0dd11149' ./ | xargs sed -i "s|000001408d77cac3e6cf652e75c7235d8656ccdd7f0abfa794f9f70e0dd11149|$GENHASH|g; "
grep -rIl '74f33e577d20398687e891958df0f9aeb0bb5e0650481df6c1b8a7730d910949' ./ | xargs sed -i "s|74f33e577d20398687e891958df0f9aeb0bb5e0650481df6c1b8a7730d910949|$MERKLEHASH|g; "
grep -rIl '1' ./ | xargs sed -i "s|1|$STAKEMINAGE|g; "
grep -rIl '6' ./ | xargs sed -i "s|6|$LASTPOW|g; "
grep -rIl '100000' ./ | xargs sed -i "s|100000|$POWREWARD|g; "

find ./ -exec rename s/sourcecoin/$LOWERNAME/ {} \;
