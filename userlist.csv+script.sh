## membuat user FreeIPA lebih dari satu ##


### create userlist.csv ####
# -hermanto@ .....
# -vernandos@.....
# -reobertos@....


### script.sh #####
#!/bin/bash

PASSWORD="P@ssw0rd123"

while IFS= read -r email; do
  username="${email%@*}"                  # hermanto.ganteng
  firstname="${username%%.*}"             # Hermanto
  lastname="${username#*.}"               # Ganteng

  # Kapitalisasi huruf pertama
  fname_cap="${firstname^}"               # Hermanto
  lname_cap="${lastname^}"                # Ganteng

  echo "Menambahkan user: $username ($fname_cap $lname_cap)"

  ipa user-add "$username" \
    --first="$fname_cap" \
    --last="$lname_cap" \
    --email="$email" \
    --password <<EOF
$PASSWORD
$PASSWORD
EOF
done < userlist.csv
