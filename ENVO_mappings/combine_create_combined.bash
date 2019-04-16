cat [Eh]*json | awk 'BEGIN { print "["; } NR > 1 { print",";} { printf "%s",$0; } END { print "]";}' >| combined_records.json
