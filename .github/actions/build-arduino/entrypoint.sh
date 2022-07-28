#!/bin/sh -l

arduino-cli  core update-index --additional-urls $INPUT_LINK

cd $GITHUB_WORKSPACE

arduino-cli core install arduino:avr

for l in $INPUT_LIBS ; do
  arduino-cli lib install $l --verbose
  if [ $? -eq 0 ]
then
  echo "Successfully installed $l"
else
  exit 1
fi
done

for i in $INPUT_FILE ; do
  arduino-cli compile -b arduino:avr:uno $i --verbose --output-dir $INPUT_OUTDIR
  if [ $? -eq 0 ]
then
  echo "Successfully compile $i"
else
  exit 1
fi
done
exit 0