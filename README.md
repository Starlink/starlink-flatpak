# Starlink flatpak

This repository contains flatpak manifests and associated files
for preparing flatpak builds of Starlink.

## Building

### Validation of metadata files

    desktop-file-validate starlink.desktop
    appstream-util validate-relax starlink.metainfo.xml
    appstream-util validate-relax starjava.metainfo.xml

### The build itself

To build into directories `build-dir-starlink` and `build-dir-starjava`
and then export to the repository:

    flatpak-builder build-dir-starlink --repo /ftp/pub/starlink/flatpak/repo edu.hawaii.eao.starlink.Starlink.json
    flatpak-builder build-dir-starjava --repo /ftp/pub/starlink/flatpak/repo edu.hawaii.eao.starlink.Starlink.StarJava.json

**Note:** the manifest files are set up to build the `master` branch
from the Git repositories as a branch `dev`.  To build a specific
release version, the `branch` must be specified, and also
given as the `runtime-version` for StarJava.  The Git branch and
commit should be specified in the sources for each module in the manifests.

To use a new runtime version, update the `runtime-version` of Starlink
and the `sdk` of StarJava.

### Maintaining the repository

If the `--repo` option is not given to `flatpak-builder`, the builds can be
exported as follows:

    flatpak build-export REPOSITORY_PATH build-dir-starlink BRANCH_NAME

**Note:** in this case the branch name must be specified manually.

To generate static deltas:

    flatpak build-update-repo -v --generate-static-deltas REPOSITORY_PATH

To clear old versions:

    flatpak build-update-repo -v --prune --prune-depth DEPTH REPOSITORY_PATH

Where DEPTH is number of old versions to keep.

## Installing

Add the repostory and install as follows:

    flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak remote-add --user --no-gpg-verify starlink https://ftp.eao.hawaii.edu/starlink/flatpak/starlink.flatpakrepo

    flatpak install --user starlink edu.hawaii.eao.starlink.Starlink
    flatpak install --user starlink edu.hawaii.eao.starlink.Starlink.StarJava

    flatpak run edu.hawaii.eao.starlink.Starlink

### Additional permissions

In order to be able to run commands outside the flatpak environment,
give the necessary permission before running:

    flatpak override --user --talk-name=org.freedesktop.Flatpak edu.hawaii.eao.starlink.Starlink

Then, inside the environment, it should be possible to use:

    flatpak-spawn --host COMMAND

### Uninstalling

Starlink can be removed as follows:

    flatpak uninstall edu.hawaii.eao.starlink.Starlink
    flatpak remote-delete starlink

And if the flathub remote is not being used for anything else, it can be removed:

    flatpak remote-delete flathub

(This should automatically remove the runtime installed for Starlink.)
