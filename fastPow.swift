 func fastPow(_ base: Int, _ power: Int, _ mod: Int) -> Int {
    var result = 1
    var b = base
    var p = power
    while p > 0 {
        if p & 1 == 1 {
            result = (result * b) % mod
        }
        b = (b * b) % mod
        p = p >> 1
    }

    return result % mod
}
