#!/bin/bash

git push upstream upstream/$1:refs/heads/_suite/$1 :$1
