import sys

for line in sys.stdin:
    arr = str.split(line.strip(), ":")
    linea = arr[0]
    fermate =  str.split(arr[1].replace(', ',',').replace("'", "\\'"), ",")
    # fermate
    for f in fermate:
        print("station('%s', %s)." % (f, linea))
    # succ
    
    fermate2 = fermate
    da = fermate2.pop(0)
    while len(fermate2) > 0:
        a = fermate2.pop(0)
        print("link('%s', '%s', %s)." % (da, a, linea))
        da = a

