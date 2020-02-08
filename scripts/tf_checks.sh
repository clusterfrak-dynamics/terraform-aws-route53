#! /bin/bash
#
find . -type f -name "*.tf" -exec dirname {} \;|sort -u | while read -r dir; do 
    terraform init -backend=false "$dir" || exit 1 
    terraform validate "$dir" || exit 1 
    terraform fmt -check -diff "$dir" && echo "Directory $(basename $dir) [√]" || exit 1
done
