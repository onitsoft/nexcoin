#!/usr/bin/env bash

#Script parameters
: ${COINNAME:="SourceCoin"} #CM_CapitalName
LOWERNAME=${COINNAME,,} #CM_LowerName
UPPERNAME=${COINNAME^^} #CM_UpperName
: ${COINCODE:="SRC"} #CM_Code
: ${REGULARPORT:='1111'} #CM_Port
: ${TESTNETPORT:='11111'} #CM_Port_Testnet
: ${RPCPORT:='2222'} #CM_RPC
: ${TESTNETRPCPORT:='22222'} #CM_RPC_Testnet
: ${VERMAJ:='1'} #CM_Version_Major
: ${VERMIN:='0'} #CM_Version_Minor
: ${VERREV:='0'} #CM_Version_Revision
: ${VERBUI:='0'} #CM_Version_Build
: ${ADDRVER:='0'} #CM_Addr_Version
: ${ALERTPUB:="0486bce1bac0d543f104cbff2bd23680056a3b9ea05e1137d2ff90eeb5e08472eb500322593a2cb06fbf8297d7beb6cd30cb90f98153b5b7cce1493749e41e0284"} #CM_AlertPubKey
: ${HEADLINE:="20 Oct 2015 A Bloomberg Run? Drums Are Beating"} #CM_Headline
: ${GENTIMESTAMP:="1445353519"} #CM_GenTimestamp
: ${GENNONCE:="61618576"} #CM_GenNonce
: ${GENHASH:="0x000001768b08da66b92dede0ea8e7dcb97424f93d7ac2ac59e7a6cf98f20615a"} #CM_GenHash
: ${MERKLEHASH:="0x2da7a0080141ea1b6e32f670af4461801b638ba867241d319c3d590d03d75614"} #CM_MerkleHash
: ${STAKEMINAGE:='1'} #CM_StakeMinAgeHrs
: ${LASTPOW:='1300'} #CM_LastPoW
: ${POWREWARD:='100000'} #CM_PoWReward

echo "Creating $COINNAME source..." 

grep -rIl 'CM_CapitalName' ./ | xargs sed -i "s|CM_CapitalName|$COINNAME|g; "
grep -rIl 'CM_LowerName' ./ | xargs sed -i "s|CM_LowerName|$LOWERNAME|g; "
grep -rIl 'CM_UpperName' ./ | xargs sed -i "s|CM_UpperName|$UPPERNAME|g; "
grep -rIl 'CM_Code' ./ | xargs sed -i "s|CM_Code|$COINCODE|g; "
grep -rIl 'CM_Port_Testnet' ./ | xargs sed -i "s|CM_Port_Testnet|$TESTNETPORT|g; "
grep -rIl 'CM_Port' ./ | xargs sed -i "s|CM_Port|$REGULARPORT|g; "
grep -rIl 'CM_RPC_Testnet' ./ | xargs sed -i "s|CM_RPC_Testnet|$TESTNETRPCPORT|g; "
grep -rIl 'CM_RPC' ./ | xargs sed -i "s|CM_RPC|$RPCPORT|g; "
grep -rIl 'CM_Version_Major' ./ | xargs sed -i "s|CM_Version_Major|$VERMAJ|g; "
grep -rIl 'CM_Version_Minor' ./ | xargs sed -i "s|CM_Version_Minor|$VERMIN|g; "
grep -rIl 'CM_Version_Revision' ./ | xargs sed -i "s|CM_Version_Revision|$VERREV|g; "
grep -rIl 'CM_Version_Build' ./ | xargs sed -i "s|CM_Version_Build|$VERBUI|g; "
grep -rIl 'CM_Addr_Version' ./ | xargs sed -i "s|CM_Addr_Version|$ADDRVER|g; "
grep -rIl 'CM_AlertPubKey' ./ | xargs sed -i "s|CM_AlertPubKey|$ALERTPUB|g; "
grep -rIl 'CM_Headline' ./ | xargs sed -i "s|CM_Headline|$HEADLINE|g; "
grep -rIl 'CM_GenTimestamp' ./ | xargs sed -i "s|CM_GenTimestamp|$GENTIMESTAMP|g; "
grep -rIl 'CM_GenNonce' ./ | xargs sed -i "s|CM_GenNonce|$GENNONCE|g; "
grep -rIl 'CM_GenHash' ./ | xargs sed -i "s|CM_GenHash|$GENHASH|g; "
grep -rIl 'CM_MerkleHash' ./ | xargs sed -i "s|CM_MerkleHash|$MERKLEHASH|g; "
grep -rIl 'CM_StakeMinAgeHrs' ./ | xargs sed -i "s|CM_StakeMinAgeHrs|$STAKEMINAGE|g; "
grep -rIl 'CM_LastPoW' ./ | xargs sed -i "s|CM_LastPoW|$LASTPOW|g; "
grep -rIl 'CM_PoWReward' ./ | xargs sed -i "s|CM_PoWReward|$POWREWARD|g; "

find ./ -exec rename s/sourcecoin/$LOWERNAME/ {} \;
