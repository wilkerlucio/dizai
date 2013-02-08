utils = angular.module("utils", [])

utils.factory "tap", -> (obj, runner) -> runner(obj); obj
utils.factory "inject", ->
  (array, accumulator, iterator) ->
    accumulator = iterator(accumulator, x) for x in array
    accumulator
