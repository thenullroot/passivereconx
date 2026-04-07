#!/bin/bash

echo "==================================="
echo "       PassiveReconX Tool          "
echo "==================================="

# Input (CLI or prompt)
target_input=$1

if [ -z "$target_input" ]; then
    echo "Enter target (domain or URL):"
    read target_input
fi

# Extract domain from URL
target=$(echo $target_input | sed -E 's|https?://||' | cut -d '/' -f1)

echo "[+] Target: $target"

# Files
crt_file="crt_$target.txt"
hack_file="hackertarget_$target.txt"
sub_file="subdomains_$target.txt"
report_file="report_$target.txt"

# =========================
# CRT.SH SOURCE
# =========================
echo "[+] Fetching subdomains from crt.sh..."

curl -s "https://crt.sh/?q=%.$target&output=json" \
| grep -oE '"name_value":"[^"]+"' \
| cut -d '"' -f4 \
| sed 's/\\n/\n/g' \
| sed 's/\*\.//g' \
| grep -E "^[a-zA-Z0-9._-]+\.$target$" \
| sort -u > $crt_file

# =========================
# HACKERTARGET SOURCE
# =========================
echo "[+] Fetching subdomains from Hackertarget..."

curl -s "https://api.hackertarget.com/hostsearch/?q=$target" \
| cut -d ',' -f1 \
| grep -E "^[a-zA-Z0-9._-]+\.$target$" \
| sort -u > $hack_file

# =========================
# MERGE
# =========================
echo "[+] Merging results..."

cat $crt_file $hack_file | sort -u > $sub_file

# Count subdomains
count=$(wc -l < $sub_file)

# =========================
# IP RESOLUTION
# =========================
echo "[+] Resolving IP..."

ip=$(dig +short $target | head -n 1)

# =========================
# HTTP HEADERS (HTTP + HTTPS fallback)
# =========================
echo "[+] Fetching HTTP headers..."

headers=$(curl -s -I http://$target 2>/dev/null)

if [ -z "$headers" ]; then
    headers=$(curl -s -I https://$target)
fi

# =========================
# REPORT GENERATION
# =========================
echo "[+] Generating report..."

{
echo "==================================="
echo "      PassiveReconX REPORT         "
echo "==================================="
echo ""
echo "TARGET: $target"
echo "IP: $ip"
echo "TOTAL SUBDOMAINS: $count"
echo ""

echo "========== SUBDOMAINS =========="
cat $sub_file
echo ""

echo "========== HTTP HEADERS =========="
echo "$headers"
echo ""

} > $report_file

# Cleanup
rm $crt_file $hack_file

echo "[✔] Report saved to $report_file"
