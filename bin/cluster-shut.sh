#!/bin/sh

#!/bin/sh
nodes=$(oc get nodes -o jsonpath='{.items[*].metadata.name}')
for node in $nodes
do
  echo $node
  oc debug node/${node} -- chroot /host shutdown -h 1
done
