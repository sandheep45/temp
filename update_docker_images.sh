#!/bin/bash

# Fetch all image names
images=$(docker images --format "{{.Repository}}:{{.Tag}}")

# Iterate over each image and pull the latest version, excluding images containing 'local' anywhere in the name
while read -r image; do
	if [[ $image != *"local"* ]]; then
		echo "Pulling latest version of $image ..."
		docker pull $image
	else
		echo "Skipping update for $image"
	fi
done <<<"$images"

echo "All Docker images updated except those containing 'local'."
