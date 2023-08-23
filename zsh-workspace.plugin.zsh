workspace (){
  readonly image=${1:?"The docker image"}
  readonly workdir="$(basename $(pwd) | tr A-Z a-z)"
  readonly name=$(echo "${workdir}-${image%.*}" | tr A-Z a-z)
  readonly container=$(docker ps -a --format "{{.ID}}|{{.Image}}" | grep "${name}" | awk -F'|' 'NR==1{print$1}') 

  local o_build=""
  local o_run=""

  zparseopts -E -D -- \
      -build:=o_build \
      -run:=o_run

  if [ ! -f "$(pwd)/${image}" ]; then
    echo "Pull $image"
    # Pull
    docker pull \
      $image ${(z)o_build[2]}
    # Run
    docker run \
      ${(z)o_run[2]} \
      --rm \
      --volume $(pwd):/workspace/$workdir \
      --workdir=/workspace/$workdir \
      --interactive --tty "$image" bash
  elif [ ! -z "${container// }" ]; then
    echo "Connect to the container"
    docker exec \
      ${(z)o_run[2]} \
      --interactive --tty "$container" bash
  else 
    echo "Create a container"
    # Build
    docker build \
      ${(z)o_build[2]} \
      --tag="$name" \
      --file=$image .
    # Run
    docker run \
      ${(z)o_run[2]} \
      --rm \
      --volume $(pwd):/workspace/$workdir \
      --workdir=/workspace/$workdir \
      --interactive --tty "$name" bash
  fi
}