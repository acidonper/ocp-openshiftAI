##
# Script to prepare Openshift Laboratory
##

##
# Users 
##
USERS="user01
user02
user03
user04
"

ADMINS="user01
user02"

##
# Adding admin user
##
htpasswd -c -b users.htpasswd admin password
oc adm policy add-cluster-role-to-user cluster-admin admin

##
# Adding users to htpasswd
##
for i in $USERS
do
  htpasswd -b users.htpasswd $i $i
done

##
# Adding Openshift AI admins
##
oc adm groups new rhods-admins
for i in $ADMINS
do
  oc adm groups add-users rhods-admins $i
done


##
# Creating htpasswd file in Openshift
##
oc delete secret lab-users -n openshift-config
oc create secret generic lab-users --from-file=htpasswd=users.htpasswd -n openshift-config

##
# Configuring OAuth to authenticate users via htpasswd
##
cat <<EOF > /tmp/oauth.yaml
apiVersion: config.openshift.io/v1
kind: OAuth
metadata:
  name: cluster
spec:
  identityProviders:
  - htpasswd:
      fileData:
        name: lab-users
    mappingMethod: claim
    name: lab-users
    type: HTPasswd
EOF

cat /tmp/oauth.yaml | oc apply -f -

# ##
# # Creating Role Binding for admin user
# ##
# oc adm policy add-cluster-role-to-user admin admin
