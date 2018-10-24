#!/usr/bin/env sh

set -eu

if [ "$#" -eq "0" ]; then
  echo "USAGE:\n    $0 OLD_VERSION NEW_VERSION SPOOFAX_VERSION\n\nReplaces \${OLD_VERSION}-SNAPSHOT with \${NEW_VERSION}-SNAPSHOT, updates Spoofax to latest nightly version. \n\${SPOOFAX_VERSION}-SNAPSHOT should also be this latest nightly version to update a file with that cannot be auto-updated with maven. "
  exit 0
fi

OLD_VERSION=$1
OLD_VERSION_SNAPSHOT="$OLD_VERSION-SNAPSHOT"
NEW_VERSION=$2
NEW_VERSION_SNAPSHOT="$NEW_VERSION-SNAPSHOT"
SPOOFAX_VERSION="$3-SNAPSHOT"

sed -i '' "s/$OLD_VERSION_SNAPSHOT/$NEW_VERSION_SNAPSHOT/g" metaborgc/metaborg.yaml
sed -i '' "s/$OLD_VERSION_SNAPSHOT/$NEW_VERSION_SNAPSHOT/g" metaborgc.example/metaborg.yaml
sed -i '' "s/$OLD_VERSION_SNAPSHOT/$NEW_VERSION_SNAPSHOT/g" metaborgc.test/metaborg.yaml
sed -i '' "s|<version>.*</version>|<version>$SPOOFAX_VERSION</version>|g" .mvn/extensions.xml

# Update Spoofax to newest released version
mvn -f pom.xml versions:update-parent -DallowSnapshots=true -DgenerateBackupPoms=false
mvn -f metaborgc/pom.xml versions:update-parent -DallowSnapshots=true -DgenerateBackupPoms=false
mvn -f metaborgc.example/pom.xml versions:update-parent -DallowSnapshots=true -DgenerateBackupPoms=false
mvn -f metaborgc.test/pom.xml versions:update-parent -DallowSnapshots=true -DgenerateBackupPoms=false
# Update projectversion to new version
mvn -f pom.xml versions:set -DnewVersion=$NEW_VERSION_SNAPSHOT -DprocessAllModules=true -DgenerateBackupPoms=false
