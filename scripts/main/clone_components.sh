#!/bin/bash
# Script to update each of the 4 main components + 2 optional ones in the IATI-SSOT repository
#
source scripts/main/CONFIG.FILE
timestamp=$(date +%s)

while getopts v:s option; do
	case "${option}" in
		v) VERSION=${OPTARG};;
		s) SSOT_ONLY=${OPTARG};;
	esac
done

# fetches the optional ssot components
# - needed if building the full website
# - not needed if building only the docs or after a version switch
if [ -z "$SSOT_ONLY" ]; then
	echo "Full build requested";
	for COMPONENT in "${OPTIONAL_COMPONENTS[@]}"; do
		if [ -d $COMPONENT ]; then
			echo "Found $COMPONENT folder, deleting and cloning again"
			rm -rf $COMPONENT
		fi

		git clone "$IATI_GIT_BASE$COMPONENT.git"
		cd $COMPONENT
		git fetch
		git checkout $DEFAULT_BRANCH
		git pull
		cd ..
	done;
fi


# fetches the main ssot components
if [ -z "$VERSION" ]; then
    VERSION=$LATEST; echo "No version specified, building version $LATEST";
else
	echo "Building version $VERSION"
fi

# - cleans up existing folders
for COMPONENT in "${SSOT_COMPONENTS[@]}"; do
	if [ -d $COMPONENT ]; then
		echo "Found $COMPONENT folder, deleting and cloning again"
		rm -rf $COMPONENT
	fi
done
rm -rf templates/
rm combined_sitemap.rst

# - clones the SSOT into a subfolder, only copies back the items we need to build
# - TODO: do the build from within the folder, without moving stuff around

git clone "$IATI_GIT_BASE$SSOT_REPO.git"

cd $SSOT_REPO

git checkout "version-$VERSION"

git submodule init
git submodule update

for COMPONENT in "${SSOT_COMPONENTS[@]}"; do
	if [ -d $COMPONENT ]; then
		cp -r $COMPONENT ..
	fi
done

cp -r templates ..
cp -r combined_sitemap.rst ..

cd ..

rm -rf $SSOT_REPO
