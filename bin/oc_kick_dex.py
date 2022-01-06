#!/usr/bin/python3

import subprocess
import re

if __name__ == '__main__':
    for line in subprocess.check_output('oc get po -A | grep gitops-dex', shell=True, text=True).splitlines():
        (namespace, pod) = line.split()[0:2]
        print(f"Namespace: {namespace} Pod: {pod}")
        subprocess.check_call(f'oc delete pod -n {namespace} {pod}', shell=True)