# dnscat2-decoder

## Usage

```bash
# Clone the repo with submodules
git clone --recursive git@github.com:jsborjesson/dnscat2-decoder.git

# You may need to run bundle in dnscat2 to get its dependencies
cd dnscat2/server
bundle

# Extract requests as text
$ tshark -r suspicious.pcap -Tfields -e dns.qry.name | grep . | grep mydomain > dnscat-data.txt

# Pipe it to this script
$ cat dnscat-data.txt | ruby decoder.rb mydomain
```

## Motivation

There are other scripts that parse data directly from a pcap-file, though they didn't work out of the box for the particular data I was trying to analyze.

This script tries to use the internals of [dnscat2](https://github.com/iagox86/dnscat2) itself to parse requests from stdin.

- https://book.hacktricks.xyz/generic-methodologies-and-resources/basic-forensic-methodology/pcap-inspection/dnscat-exfiltration
- https://github.com/Disturbante/Dnscat-decoder/
- https://github.com/josemlwdf/DNScat-Decoder
