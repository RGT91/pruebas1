# FizzBuzz
indice = 1
while indice < 31:
   otro = True
   if indice % 3 == 0:
      print "fizz"
      otro = False

   if indice %5 == 0:
      print "buzz"
      otro = False

   if otro:
      print indice

   print "\n"
   indice = indice + 1
