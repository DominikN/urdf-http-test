start:
    #!/usr/bin/env bash
    set -euo pipefail

    cat $HOME/.ssh/*.pub > ./authorized_keys

    docker compose up -d --build

    # Tear everything down on normal exit or on INT/TERM
    trap 'echo "🧹  docker compose down"; docker compose down' EXIT INT TERM

    sleep 1

    # Forward X11 and launch the demo app
    ssh -X -p 2222 root@127.0.0.1 'source /opt/ros/jazzy/setup.bash && rviz2'