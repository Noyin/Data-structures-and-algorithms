 func primeFactors(_ n: Int) -> [Int] {
    var n = n
    var factors: [Int] = []

    var divisor = 2
    while divisor * divisor <= n {
        while n % divisor == 0 {
            factors.append(divisor)
            n /= divisor
        }
        divisor += divisor == 2 ? 1 : 2
    }
    if n > 1 {
        factors.append(n)
    }

    return factors
}
