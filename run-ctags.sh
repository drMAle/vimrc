if [ -f ./tags ]; then
   echo "Tagfile exists. Updating..."
   find -name '*.c' -newer tags -o -name '*.cpp' -newer tags -o -name '*.h' -newer tags > /tmp/ctagslist
   ctags --recurse --verbose --append --extra=+q --fields=+aimS --c-kinds=+p --c++-kinds=+p -L /tmp/ctagslist
else
   echo "Tagfile does not exist. Creating..."
   find -name '*.c' -o -name '*.cpp' -o -name '*.h' > /tmp/ctagslist
   ctags --recurse --verbose --append --extra=+q --fields=+aimS --c-kinds=+p --c++-kinds=+p -L /tmp/ctagslist
fi

