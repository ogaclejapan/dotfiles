function dockertags -d 'Find a tag by repository name from Docker Hub'
    if not type -q jq
        echo "jq: command not found" >&2
        return 1
    end

    if test (count $argv) -eq 0
        echo "docker-tags <name>: name is required" >&2
        return 1
    end

    set -l name $argv[1]
    curl -s "https://registry.hub.docker.com/v1/repositories/$name/tags" | jq -r '.[].name'
end
