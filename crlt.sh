# files normalization: add new line at the end of files

# git ls-files --others \
#     --modified \
#     --exclude=Tukui/medias/fonts/* \
#     --exclude=Tukui/medias/sounds/* \
#     --exclude=Tukui/medias/textures/* \
#     -z | while IFS= read -rd '' f; do tail -c1 < "$f" | read -r _ || echo >> "$f"; done

find -type f \( -iname *.lua -o -iname *.xml -o -iname *.toc -o -iname *.txt \) | while read f; do tail -n1 $f | read -r _ || echo >> $f; done
