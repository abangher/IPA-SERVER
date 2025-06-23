## membuat user FreeIPA lebih dari satu ##


### create userlist.csv ####
# -hermanto@ .....
# -vernandos@.....
# -reobertos@....


### script.sh #####
PASSWORD="P@ssw0rd123"

while IFS= read -r email; do
  username="${email%@*}"
  ipa user-add "$username" \
    --first="User" \
    --last="$username" \
    --email="$email" \
    --password <<EOF
$PASSWORD
$PASSWORD
EOF
done < userlist.csv
