describe "Utils", ->
  beforeEach -> module("utils")

  describe "tap", ->
    it "run a function with a given arg, them return the arg", inject (tap) ->
      array = tap [], (obj) -> obj.push("sample")

      expect(array).toEqual(["sample"])

  describe "inject", ->
    it "iterates over an array, injecting the value with the response", inject (inject) ->
      data = [1, 2, 3]
      sum = inject data, 0, (s, n) -> s + n

      expect(sum).toEqual(6)
