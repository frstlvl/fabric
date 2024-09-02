#!/bin/bash
# checks mx, spf, dkim (M365, Google, other common defaults), and dmarc records

DOMAIN="${1}"

echo -e "\nMX record:\n"
dig +short mx $DOMAIN

echo -e "\nSPF record:\n"
dig +short txt $DOMAIN | grep -i "spf"

echo -e "\nDKIM keys (M365 default selectors):\n"
dig +short txt selector1._domainkey.$DOMAIN # m365 default selector
dig +short txt selector2._domainkey.$DOMAIN # m365 default selector

echo -e "\nDKIM keys (Google default selector):"
dig +short txt google._domainkey.$DOMAIN # m365 default selector

echo -e "\nDKIM keys (Other common default selectors):\n"
dig +short txt s1._domainkey.$DOMAIN
dig +short txt s2._domainkey.$DOMAIN
dig +short txt k1._domainkey.$DOMAIN
dig +short txt k2._domainkey.$DOMAIN

echo -e  "\nDMARC policy:\n"
dig +short txt _dmarc.$DOMAIN
dig +short ns _dmarc.$DOMAIN

# these should open in the default browser
open "https://dmarcian.com/domain-checker/?domain=$DOMAIN"
open "https://domain-checker.valimail.com/dmarc/$DOMAIN"
