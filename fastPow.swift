func fastPow(_ n, _ mod: Int) -> Int {
  var n = n 
  var res = 1
  var base = 2

  while n > 0 {
      if n % 2 == 1 {
          res = (res * base) % mod
      }

      base = (base * base) % mod

      n >>= 1
  }
  
  return res
}
