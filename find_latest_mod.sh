#!/bin/sh

# create the file if !exists
if [ ! -f "/tmp/dataval.dat" ] ; then
  echo "Never ran before, setting to 0"
  oldvalue=0
else
  oldvalue=`cat /tmp/dataval.dat`
  echo "Last run was: ${oldvalue}"
fi

# Run our latest script checker
value=`find $1 -type f -print0  | xargs -0 stat -f "%m %N" | sort -n | tail -1 | cut -d" " -f1`

echo "Found an object with ${value}"

# Save for next run
echo "${value}" > /tmp/dataval.dat

# Do some stuff based on the fact something changed or not
if [ "$oldvalue" -ne "$value" ] ; then
  echo "Something changed.."
  # xcodebuild -target 'MyAppName.xcodeproj' -scheme 'MyAppName' -configuration "Release" .....
else
  echo "Nothing changed. Exiting."
fi
