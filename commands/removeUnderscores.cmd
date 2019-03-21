
#arguments are the files to not be changed

untouched_files=${untouched_files}"$@"

regex_untouched_files="[^("

counter=0
stop=$(($# - 1))

for file in ${untouched_files} ; do
  regex_untouched_files=${regex_untouched_files}"${file}"
  regex_untouched_files=${regex_untouched_files}")"
  if [[ ${counter} -lt ${stop} ]] ; then
    regex_untouched_files=${regex_untouched_files}"|("
  fi
  counter=$((${counter} + 1))
done

if [[ $# -eq 0 ]] ; then
  regex_untouched_files=${regex_untouched_files}")" 
fi

regex_untouched_files=${regex_untouched_files}"]"

files_to_be_renamed=`ls -1 | egrep "_" | egrep "${regex_untouched_files}"`

if [[ -z ${files_to_be_renamed} ]] ; then 
  echo "No file will be changed"
fi

for file in ${files_to_be_renamed} ; do
   new_file_name=`echo ${file} | sed s/_/\ /g`
   echo "Renaming  ${file}  in  ${new_file_name}"
   mv "${file}" "${new_file_name}"
done

