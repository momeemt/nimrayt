import lib/image

var img = Image.init(200, 100, "dist/gradation.ppm")

for y in 0'u..<100:
  for x in 0'u..<200:
    let
      red = x.float / 200 * 255
      green = y.float / 100 * 255
      blue = 0.5 * 255
    img[(x, y)] = (red.uint8, green.uint8, blue.uint8)

img.write()
