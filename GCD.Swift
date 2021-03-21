func gcd(_ a:Int, _ b:Int) -> Int {
    if a == b {
        return a
    }
    else {
        if a > b {
            return gcd(a-b, b)
        }
        else {
            return gcd(a, b-a)
        }
    }
}
