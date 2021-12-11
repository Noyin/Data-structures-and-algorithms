func intersects(_ first: [Int], _ second: [Int]) -> Bool {
  let dx = abs(first[0] - second[0])
  let dy = abs(first[1] - second[1])
  let length = (dx * dx) + (dy * dy)
  return abs(first[2] - second[2]) <= length && length  <=  abs(first[2] + second[2]) 
}
