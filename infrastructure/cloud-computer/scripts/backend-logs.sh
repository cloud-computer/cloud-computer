containers=$(yarn --cwd ../docker docker ps --filter label=tier=backend --filter label=namespace=api --format "{{.Names}}")

for container in $containers; do
  eval "docker logs $container --follow --tail=5 &"
done

cleanup () {
  # Using `sh -c` so that if some have exited, that error will
  # not prevent further tails from being killed.
  jobs -p | tr '\n' ' ' | xargs -I % sh -c "kill % || true"
}

# On ctrl+c, kill all tails started by this script.
trap cleanup EXIT

# Don't exit this script until ctrl+c or all tails exit.
wait
