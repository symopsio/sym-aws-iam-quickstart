#!/bin/bash

DIR="$(mktemp -d)"
claat export -o $DIR walkthrough.md

cp -r $DIR/sym_iam_quickstart/ ../docs