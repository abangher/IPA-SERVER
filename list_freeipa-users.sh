## list_freeipa_users.sh 
## ./list_freeipa_user.sh

ipa user-find --all --sizelimit=0 | awk '
BEGIN {
  format="| %-18s | %-12s | %-12s | %-8s | %-10s | %-10s |\n"
  line="|--------------------|--------------|--------------|----------|------------|------------|"
  print line
  printf format, "UserLogin", "FirstName", "LastName", "Status", "UID", "GID"
  print line
  count=0
}
/User login:/ {login=$3}
/Full name:/ {
  fullname=$3
  for(i=4;i<=NF;i++) fullname=fullname " " $i
}
/Last name:/ {lastname=$3}
/UID:/ {uid=$2}
/GID:/ {
  gid=$2
  split(fullname, arr, " ")
  firstname=arr[1]
  status="enabled"
  printf format, login, firstname, lastname, status, uid, gid
  count++
  login=""; firstname=""; lastname=""; fullname=""; uid=""; gid=""
}
END {
  print line
  printf("| Total Users: %-67d |\n", count)
  print line
}'
