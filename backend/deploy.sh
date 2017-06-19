#!/usr/bin/env bash
dir=`dirname $0`
if [ $# -ne 1 ]; then
    echo "please specify the version as a parameter."
    echo "you can try to take whatever is reported by git describe (note example dev path):"
    echo ""
    echo "sh $dir/deploy.sh \$(cd ../scala-fun-backend; git describe --tags)"
    exit -1
fi
version=$1
sed "s/%%VERSION%%/$version/" $dir/deployment.template.yml > $dir/deployment.yml
cat $dir/deployment.yml

kubectl replace -f $dir/deployment.yml --record || \
    ( \
        kubectl create -f $dir/deployment.yml --record && \
        kubectl expose deployment scala-fun-backend --target-port=8080 \
    )
