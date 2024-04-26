# Openshift AI

## Introduction

Red Hat OpenShift AI is a platform for data scientists and developers of artificial intelligence (AI) applications. It provides a fully supported environment that lets you rapidly develop, train, test, and deploy machine learning models on-premises and/or in the public cloud.

OpenShift AI integrates the following components and services:

At the service layer:

* OpenShift AI dashboard: A customer-facing dashboard that shows available and installed applications for the OpenShift AI environment as well as learning resources such as tutorials, quick starts, and documentation. Administrative users can access functionality to manage users, clusters, notebook images, accelerator profiles, and model-serving runtimes. Data scientists can use the dashboard to create projects to organize their data science work.
* Model serving: Data scientists can deploy trained machine-learning models to serve intelligent applications in production. After deployment, applications can send requests to the model using its deployed API endpoint.
* Data science pipelines: Data scientists can build portable machine learning (ML) workflows with data science pipelines, using Docker containers. This enables your data scientists to automate workflows as they develop their data science models.
* Jupyter (self-managed): A self-managed application that allows data scientists to configure their own notebook server environment and develop machine learning models in JupyterLab.
* Distributed workloads: Data scientists can use multiple nodes in parallel to train machine-learning models or process data more quickly. This approach significantly reduces the task completion time, and enables the use of larger datasets and more complex models.

At the management layer:

* The Red Hat OpenShift AI Operator: A meta-operator that deploys and maintains all components and sub-operators that are part of OpenShift AI.
* Monitoring services: Prometheus gathers metrics from OpenShift AI for monitoring purposes.

The namespaces installed by the OpenShift AI operator are:

* __redhat-ods-operator__ contains the Red Hat OpenShift AI Operator.
* __redhat-ods-applications__ installs the dashboard and other required components of OpenShift AI.
* __redhat-ods-monitoring__ contains services for monitoring.
* __rhods-notebooks__ is where notebook environments are deployed by default.

## Requirements

* OCP 4.14+
* Identity Provider, Storage and Internet Access
* RH Pipelines Operator
* KServe Dependencies
* * Red Hat Openshift Serverless
* * Red Hat Openshift Service Mesh


## Setting Up Openshift AI

It is time to deploy Openshift AI in a Openshift cluster from the scratch. Please follow next steps for performing this task:

* Create Users and define Openshift AI Admins

```$bash
sh scripts/setup_lab_multi.sh

# This script creates user01, user02, user03 and user04 and adds user01 and user02 to rhods-admins groups 
NOTE: Authentication is based on Htpasswd and the users' password is the username
NOTE: By default, Data Science user group is system_authenticated users.
```

* Install Operators

```$bash
oc apply -f files/operator-openshiftai.yaml
oc apply -f files/operator-kserver-prerequisites.yaml
```

* Install the _DataScienceClsuter_

```$bash
oc apply -f files/datasciencecluster.yaml
```

* Check Installation via script

```$bash
sh scripts/check.sh
```

* Check the installation vía Dashboard with user01 (admin) and user03 (Data Science user)

```$bash
oc get routes rhods-dashboard -n redhat-ods-applications -o jsonpath='{.spec.host}'
```

## Openshift AI Operator Objects

* DataScienceCluster: Install Red Hat OpenShift AI components.
* * Dashboard -> Openshift AI Dashboard + RBAC

## Components

* KServe provides a Kubernetes Custom Resource Definition for serving predictive and generative machine learning (ML) models. It aims to solve production model serving use cases by providing high abstraction interfaces for Tensorflow, XGBoost, ScikitLearn, PyTorch, Huggingface Transformer/LLM models using standardized data plane protocols

## Author

Asier Cidon @Red Hat
