import arraymancer

type Ray* = object
  origin: Tensor[float]
  direction: Tensor[float]

proc init* (_: typedesc[Ray], origin, direction: Tensor[float]): Ray =
  result = Ray(origin: origin, direction: direction)

proc at* (ray: Ray, t: float): Tensor[float] =
  result = ray.origin + t * ray.direction
