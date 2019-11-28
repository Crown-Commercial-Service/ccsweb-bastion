#!/bin/bash
# System setup

echo "Starting codedeploy server_setup.sh ..."

SCRIPTDIR=$(dirname $0)
FIRST_RUN_PATH="/codedeploy.server_setup"

# Update system packages
sudo yum update -y

# Tasks to only run once for a given server
if [ ! -e "$FIRST_RUN_PATH" ]; then
    # Install/setup AWS CW logging
    sudo yum install -y awslogs

    sudo chown root:root \
        "$SCRIPTDIR/files/awscli.conf" \
        "$SCRIPTDIR/files/awslogs.conf"

    sudo chmod 640 \
        "$SCRIPTDIR/files/awscli.conf" \
        "$SCRIPTDIR/files/awslogs.conf"

    sudo mv -f \
        "$SCRIPTDIR/files/awscli.conf" \
        "$SCRIPTDIR/files/awslogs.conf" \
        /etc/awslogs/

    sudo touch "$FIRST_RUN_PATH"
fi

echo "Codedeploy server_setup.sh complete."
