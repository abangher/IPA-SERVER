## list_freeipa_users.sh 
## ./list_freeipa_user.sh

ipa user-find --all --sizelimit=0 | \
awk '
BEGIN {
  print "UserLogin\tFirstName\tLastName\tStatus\tUID"
}
/User login:/ {login=$3}
/Full name:/ {fullname=$3; for(i=4;i<=NF;i++) fullname=fullname " " $i}
/Last name:/ {lastname=$3}
/UID:/ {uid=$2; 
  # Ambil first name dari fullname (kata pertama)
  split(fullname, arr, " ")
  firstname=arr[1]
  # Status tidak ada, default enabled
  status="enabled"
  print login "\t" firstname "\t" lastname "\t" status "\t" uid
  # reset variabel supaya gak salah di user berikutnya
  login=""; firstname=""; lastname=""; fullname=""; status=""; uid=""
}
' | column -t



