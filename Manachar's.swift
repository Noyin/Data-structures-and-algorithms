/// Gets numbers of palindromic substrings
func manachar(_ s: String, _ even: Bool) -> Int {
    var dp = Array(repeating: 0, count: s.count)
    var s = Array(s)
    var l = 0
    var r = -1
    for i in 0..<s.count {
        var k = i > r ? 1 - (even ? 1 : 0) : min(dp[l + r - i + (even ? 1 : 0)], r - i + 1)
        while 0 <= i - k - (even ? 1 : 0) && i + k < s.count && s[i - k - (even ? 1 : 0)] == 
        s[i + k] {
            k += 1
        }

        dp[i] = k
        k -= 1
        if i + k > r {
            r = i + k
            l = i - k - (even ? 1 : 0)
        }
    }

    return dp.reduce(0, +)
}
