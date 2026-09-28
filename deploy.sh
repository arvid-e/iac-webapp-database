#!/bin/bash

cd terraform
tofu init
tofu apply -auto-approve
