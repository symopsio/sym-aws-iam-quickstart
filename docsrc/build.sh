#!/bin/bash

DIR="$(mktemp -d)"
claat export -o $DIR walkthrough.md

cp -r $DIR/sym_aws_iam_quickstart/ ../docs
