#!/bin/bash
## Gathers results of simulations run via OptionPriceVsB_RunSimulations.sh
## in a single file fit for analysis via astropy.io in Python 3.

OUTPUTFILE="optionpricevsb_gatheredresults.dat"
DIRECTORY="OptionPriceVsB"

cd ../outputs/${DIRECTORY};
echo "B N exactPrice exactError eulerPrice eulerError" > ${OUTPUTFILE};
grep "estimated" output* \
| awk '{gsub("output__","");print}' \
| awk '{gsub("_"," ");print}' \
| sed -e '/^.*\(estimated price via Euler formula\)/s/^.*\(EUR\]: \)//' \
| sed -e '/^.*\(estimated error via Euler formula\)/s/^.*\(EUR\]: \)//' \
| sed -e '/^.*\(estimated error via exact formula\)/s/^.*\(EUR\]: \)//' \
| paste -d' ' - - - - \
| awk '{gsub(".dat:Monte Carlo estimated price via exact formula \\[EUR\\]:", "");print}' \
>> ${OUTPUTFILE};

exit 0
