func intersects(_ first: [Int], _ second: [Int]) -> Bool {
  let dx = abs(first[0] - second[0])
  let dy = abs(first[1] - second[1])
  let length = first[2] * first[2]
  return dx * dx + dy * dy <= length 
}
