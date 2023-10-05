#!/bin/bash

VSCODE_VERSION="$1"
VSCODE_COMMIT_ID="$2"

set -uexo pipefail

VSCODIUM_DIR="${HOME}/.vscodium-server"

mkdir -p "${VSCODIUM_DIR}"
pushd "${VSCODIUM_DIR}"

# Because VSCodium builds have sub version numbers (grrr...) we need to get a list of tags via GitHub API
#  then figure it out based on $VSCODE_VERSION and $VSCODE_COMMIT_ID. We only keep the version that matches commit ID.
for release_tag in $(curl -s 'https://api.github.com/repos/VSCodium/vscodium/tags' | grep '"name"' | grep "${VSCODE_VERSION}" | cut -d'"' -f4); do
    PACKAGE="vscodium-reh-linux-x64-${release_tag}.tar.gz"
    DOWNLOAD_URL="https://github.com/VSCodium/vscodium/releases/download/${release_tag}/${PACKAGE}"

    ARCHIVE_PATH="${VSCODIUM_DIR}/${PACKAGE}"

    curl -Ls -o "${ARCHIVE_PATH}" "${DOWNLOAD_URL}"
    COMMIT_ID="$(tar -xf "${ARCHIVE_PATH}" ./product.json -O | grep -m1 'commit' | cut -d'"' -f4)"
    set +e
    if [ "${VSCODE_COMMIT_ID}" != "${COMMIT_ID}" ]; then
        rm "${ARCHIVE_PATH}"
        continue
    fi
    set -e
    break
done

BIN_DIR="${VSCODIUM_DIR}/bin/${COMMIT_ID}"
mkdir -p "${BIN_DIR}"
pushd "${BIN_DIR}"
tar -xf "${ARCHIVE_PATH}"
popd

ln -sfT "${BIN_DIR}" "${VSCODIUM_DIR}/bin/current"
rm "${ARCHIVE_PATH}"
