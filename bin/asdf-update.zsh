#!/bin/zsh

# List of plugins where all versions must remain installed
# Add plugin names to this array as needed
exceptions=("protonge")

# Makes Erlang build-install faster
KERL_CONFIGURE_OPTIONS="--disable-debug --without-javac"

# Get list of installed plugins
plugins=($(asdf plugin list))

for plugin in $plugins; do
    # Get latest version
    latest=$(asdf latest $plugin 2>/dev/null)
    if [[ -z "$latest" ]] || [[ "$latest" == "No compatible versions"* ]] || [[ "$latest" == "unable to"* ]]; then
        echo "No latest version found for $plugin, skipping"
        continue
    fi
    # Get current global version before updating
    current=$(asdf current --no-header $plugin 2>/dev/null | awk '{print $2}')
    # Install latest version (asdf handles if already installed)
    asdf install $plugin $latest >/dev/null 2>&1
    # Verify installation succeeded before proceeding
    if ! asdf list $plugin 2>/dev/null | grep -q "$latest"; then
        echo "Failed to install $plugin $latest, skipping cleanup"
        continue
    fi
    # Set global to latest
    (cd ~ && asdf set $plugin $latest >/dev/null 2>&1)
    if [[ "$current" == "$latest" ]]; then
        echo "$plugin was already $latest"
    else
        echo "$plugin updated $current -> $latest"
    fi

    if [[ ! " ${exceptions[@]} " =~ " $plugin " ]]; then
        # Get all installed versions
        installed_versions=($(asdf list $plugin 2>/dev/null | awk 'NF{print $NF}'))
        for version in $installed_versions; do
            if [[ "$version" != "$latest" ]]; then
                asdf uninstall $plugin $version >/dev/null 2>&1
            fi
        done
    fi
done

echo "Update complete."
