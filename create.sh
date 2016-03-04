#!/usr/bin/env bash

: ${COINNAME:="SourceCoin"}
echo $COINNAME

LOWERNAME=${COINNAME,,}
echo $LOWERNAME

UPPERNAME=${COINNAME^^}
echo $UPPERNAME

grep -rIl 'CM_CapitalName' ./ | xargs sed -i "s|CM_CapitalName|$COINNAME|g; "
grep -rIl 'CM_LowerName' ./ | xargs sed -i "s|CM_LowerName|$LOWERNAME|g; "
grep -rIl 'CM_UpperName' ./ | xargs sed -i "s|CM_UpperName|$UPPERNAME|g; "

find ./ -exec rename s/sourcecoin/$LOWERNAME/ {} \;
