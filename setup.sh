python3 txt2pl.py < metropolitana-milano.txt | sort > graph.pl
# curl "http://www.trenord.it/it/circolazione-e-linee/le-linee/linee-s/s13.aspx" | fgrep  -f linee-suburbane.fgrep  | sed -e 's:<br/>:,:' -e 's: - ::'
