
#!/bin/bash
########### Update plugin name and set files #########

 tc() { set ${*,,} ; echo ${*^} ; }

echo "What is this plugin called (e.g. My Plugin), followed by [ENTER]:"

read PLUGIN_NAME

#echo "What is this class called (My_Plugin), followed by [ENTER]:"

PLUGIN_PASCAL="$(echo ${PLUGIN_NAME} | sed -e 's/ /_/')"

# Convert name to snake case for files
PLUGIN_KEBAB="$(echo ${PLUGIN_NAME} | sed -e 's/ /\-/' | awk '{print tolower($0)}')"

### Validate inputs
if [ -z ${PLUGIN_NAME+x} ] ; then
  echo "Plugin Name must be set"
  exit 1
fi

# Recursively rename files first
find . -type f -name '*plugin-name*' | while read FILE ; do
    newfile="$(echo ${FILE} | sed -e 's/plugin-name/'${PLUGIN_KEBAB}'/g')" ;
    echo $FILE " --> " $newfile
    mkdir -p "${newfile}"
    mv "${FILE}" "${newfile}" ;
done 

# Remove original files that remain
rm -r plugin-name

# Replace snake case instances
find . -type f ! -name '*.sh' -exec sed -i '' -e 's/Plugin_Name/'${PLUGIN_PASCAL}'/g' {} +

# Replace snake case instances
find . -type f ! -name '*.sh' -exec sed -i '' -e 's/plugin-name/'${PLUGIN_KEBAB}'/g' {} +
