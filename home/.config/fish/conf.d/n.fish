function __n_version_on_cd --on-variable PWD  -d 'Automatic node.js version switching for n'
    if not test -e .node-version; or not type -q node; or not type -q n
        return 0
    end
    set -l current_version (node -v | sed -e 's/^v//')
    set -l specified_version (cat .node-version)
    if __n_version_test $specified_version $current_version
        return 0
    end
    read --prompt "set_color blue; echo -n '.node-version'; set_color normal; echo ' file found. must be $specified_version or higher'; echo -n 'Switch to the specified version? '; set_color green; echo -n '($current_version -> $specified_version)'; set_color normal; echo -n ' [Y/n]: '" --command 'Y' answer
    if test $answer != 'Y'
        return 0
    end
    n $specified_version
end

function __n_version_test -a expected actual -d "Compare versions"
	printf '%s\n' $expected $actual | sort --check=silent --version-sort
	return $status
end
