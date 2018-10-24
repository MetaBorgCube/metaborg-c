#!/usr/bin/env sh

set -eu

if [ "$#" -eq "0" ]; then
  echo "USAGE:\n    $0 VERSION SPOOFAX_VERSION\n    $0 OLD_VERSION NEW_VERSION SPOOFAX_VERSION\n\nThe first option assumes you are on the given version and just want to strip off the -SNAPSHOT. \n\nReplaces \${OLD_VERSION}-SNAPSHOT with \$NEW_VERSION, updates Spoofax to latest release version. \n\$SPOOFAX_VERSION should also be this latest release version to update a file with that cannot be auto-updated with maven. "
  exit 0
fi

if [ "$#" -eq "3" ]; then
  OLD_VERSION=$1
  NEW_VERSION=$2
  SPOOFAX_VERSION=$3
else
  OLD_VERSION=$1
  NEW_VERSION=$1
  SPOOFAX_VERSION=$2
fi

sed -i '' "s/$OLD_VERSION-SNAPSHOT/$NEW_VERSION/g" metaborgc/metaborg.yaml
sed -i '' "s/$OLD_VERSION-SNAPSHOT/$NEW_VERSION/g" metaborgc.example/metaborg.yaml
sed -i '' "s/$OLD_VERSION-SNAPSHOT/$NEW_VERSION/g" metaborgc.test/metaborg.yaml
sed -i '' "s|<version>.*</version>|<version>$SPOOFAX_VERSION</version>|g" .mvn/extensions.xml

# Update Spoofax to newest released version
mvn -f pom.xml versions:update-parent -DgenerateBackupPoms=false
mvn -f metaborgc/pom.xml versions:update-parent -DgenerateBackupPoms=false
mvn -f metaborgc.example/pom.xml versions:update-parent -DgenerateBackupPoms=false
mvn -f metaborgc.test/pom.xml versions:update-parent -DgenerateBackupPoms=false
# Update project version to new version
mvn -f pom.xml versions:set -DnewVersion=$NEW_VERSION -DprocessAllModules=true -DgenerateBackupPoms=false
