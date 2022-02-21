import std/sequtils
import pnm

type
  Position = tuple
    x, y: uint
  RGB = tuple
    r, g, b: uint8
  Image* = object
    path: string
    pixels: seq[seq[RGB]]
    width: uint
    height: uint

proc init* (_: typedesc[Image], width, height: uint, path: string): Image =
  result = Image(
    path: path,
    width: width,
    height: height,
    pixels: newSeqWith(height.int, newSeq[RGB](width.int))
  )

proc `[]`* (img: Image, pos: Position): RGB =
  result = img.pixels[pos.y][pos.x]

proc `[]=`* (img: var Image, pos: Position, rgb: RGB) =
  img.pixels[pos.y][pos.x] = rgb

proc flat (pixels: seq[seq[RGB]]): seq[uint8] =
  result = @[]
  for y in 0..pixels.high:
    for x in 0..pixels[0].high:
      let pixel: RGB = pixels[y][x]
      result.add pixel.r
      result.add pixel.g
      result.add pixel.b

proc write* (img: Image) =
  let ppm = pnm.newPPM(
    pnm.ppmFileDescriptorP6,
    img.height.int,
    img.width.int,
    255,
    img.pixels.flat
  )
  writePPMFile(img.path, ppm)
