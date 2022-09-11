func is(point: [Int], insideCircle cirle: [Int]) -> Bool {
  return pow(Double(point[0]) - Double(cirle[0]), 2.0) + pow(Double(point[1]) - Double(cirle[1]), 2.0) <= pow(Double(cirle[2]), 2.0)
}
