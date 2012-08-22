import math
from geoserver.catalog import Catalog
from geoserver.wps import process
from geoscript.geom import Point
from geoscript.feature import Schema
from geoscript.layer import Layer

@process(

  # human readable title
  title = 'Distance and Bearing',

  # describe process
  description = 'Computes Cartesian distance and bearing from features to an origin.',

  # describe input parameters
  inputs = {
    'origin': (Point, 'The origin from which to calculate distance and bearing.'), 
    'features': (Layer, 'The features to which distance and bearing should be calculated.')
  },

  # describe output parameters
  outputs = {
    'result': (Layer, 'Features with calculated distance and bearing attributes.')
  }
)

# provide a function that accepts inputs and returns outputs
def run(origin, features):

  # create a layer to hold the results
  results = Layer(schema=Schema('results', 
     [('point', Point), ('distance', float), ('bearing', float)]))

  # query the source layer and compute the results
  for f in features.features():
    p = f.geom
    d = p.distance(origin)
    b = 90 - math.degrees(math.atan2(p.y - origin.y, p.x - origin.x))
        
    results.add([p, d, b])

  return results
