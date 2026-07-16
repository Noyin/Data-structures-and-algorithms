func gcd(_ a: Int, _ b: Int) -> Int {
        if a % b == 0 || b % a == 0 {
            return min(a, b)
        }

        if a == b {
            return a
        }

        if a < b {
            return gcd(a, b % a)
        }

        return gcd(a % b, b)
    }
   
func lcm(_ x: Int, _ y: Int) -> Int {
   return x / gcd(x, y) * y
}
