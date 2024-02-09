rm -rf .repo/local_manifests && 
# Initialize repo with specified manifest
repo init --depth 1 -u https://github.com/LineageOS/android.git -b lineage-20.0 --git-lfs && 
# Clone local_manifests repository
git clone https://github.com/igniteinm/local_manifest --depth 1 -b van .repo/local_manifests && 
# Sync the repositories
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags && \ 

# Clone Cromite app
#rm -rf vendor/plros/prebuilt/apps/Cromite

#git clone https://gitlab.com/plros-lab/android_packages_apps_Cromite.git vendor/plros/prebuilt/apps/Cromite && 
# Set up build environment
source build/envsetup.sh && 
# Lunch configuration
lunch lineage_beryllium-user && 
# Build the ROM
mka bacon && echo Date and time: && 
# Print out/build_date.txt
cat out/build_date.txt
 echo 
# Print SHA256
sha256sum out/target/product/*/*.zip

# Pull generated zip files
crave pull out/target/product/*/*.zip 

# Pull generated img files
# crave pull out/target/product/*/*.img

# Upload zips to Telegram
# telegram-upload --to sdreleases oxygen/*.zip

#Upload to Github Releases
#curl -sf https://raw.githubusercontent.com/Meghthedev/Releases/main/headless.sh | sh
