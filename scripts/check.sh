#!/bin/bash
##
# Script to check Openshift AI installation
##

echo "# Check Openshift Operator..."
oc get operator rhods-operator.redhat-ods-operator -n redhat-ods-operator
sleep 1

echo ""
echo "# List Openshift AI namespaces..."
oc get projects | grep ods
sleep 1

echo ""
echo "# Check KServer Prerequisites - Operators ..."
oc get operators jaeger-product.openshift-operators | grep -v NAME
oc get operators kiali-ossm.openshift-operators | grep -v NAME       
oc get operators serverless-operator.openshift-operators | grep -v NAME
oc get operators servicemeshoperator.openshift-operators | grep -v NAME
sleep 1

echo ""
echo "# Check DataScienceCluster ..."
oc get datasciencecluster default-dsc -n redhat-ods-operator
sleep 1

echo ""
echo "# Check Openshift AI Dashboard ..."
oc get pod -n redhat-ods-applications | grep dashboard
sleep 1

echo ""
echo "# Check Users ..."
oc get groups
sleep 1


