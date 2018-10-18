# Uses the default shell




# check the number of arguments
if [[ $# -ge 1 ]] ; then
    ARG_INDEX=1
    while [[ ARG_INDEX -le $# ]] ; do
        case ${!ARG_INDEX} in
            # the next files will have the shell specified by path as used shell until another "-s" option
            "-s") (( ARG_INDEX = ARG_INDEX + 1 ))
                  BASH_PATH=${!ARG_INDEX}
                  (( ARG_INDEX = ARG_INDEX + 1 ))
                  ;;
            *)    FILE_NAME=${!ARG_INDEX}
                  if [[ -n ${FILE_NAME} ]] ; then
                      if [[ -e ${FILE_NAME} ]] ; then
                          echo "A file called ${FILE_NAME} already exists"
                      else
                          touch ${FILE_NAME}
                          chmod u+x ${FILE_NAME}
                          echo "File \"${FILE_NAME}\" created successfully"
                          if [[ -n ${BASH_PATH} ]] ; then
                              echo "#!${BASH_PATH}" > "./${FILE_NAME}"
                          fi
                      fi
                      ((ARG_INDEX=ARG_INDEX+1))
                  fi
                  ;;
        esac
    done
else
    echo "usage: mkscript [-options] [filenames]"
    exit 1
fi

# in /etc/profile custom path
# in /home/user/.bashrc custom alias
