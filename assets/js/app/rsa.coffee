rsa = angular.module("rsa", ["utils"])

class Base64EncodedRSAKey extends RSAKey
  encrypt: (string) -> hex2b64(super(string))
  decrypt: (string) -> super(b64tohex(string))

class ChunkedString
  constructor: (@string, @size) ->
  each: (iterator) ->
    chunks = Math.ceil(@string.length / @size)

    for i in [0...chunks]
      x = i * @size
      chunk = @string.substr(x, @size)
      iterator(chunk)

  inject: (accumulator, iterator) ->
    @each (chunk) -> accumulator = iterator(accumulator, chunk)
    accumulator

rsa.factory "RSAKey", ["inject", (inject) ->
  class MultiChunkRSAKey extends Base64EncodedRSAKey
    encrypt: (string) ->
      new ChunkedString(string, chunkEncodeSize.call(@))
        .inject [], (encrypted, chunk) =>
          encrypted.concat([super(chunk)])
        .join("#")

    decrypt: (string) ->
      inject string.split("#"), "", (acc, chunk) =>
        acc + super(chunk)

    chunkDecodeSize = -> @n.toString(16).length
    chunkEncodeSize = -> Math.floor(chunkDecodeSize.call(@) / 2) - 11
]

rsa.factory "keygen", ["RSAKey", "tap", (RSAKey, tap) ->
  (bits = 1024, exponent = "10001") ->
    tap new RSAKey(), (rsa) -> rsa.generate(bits, exponent)
]

rsa.factory "toPubKey", ->
  (key) -> {n: key.n.toString(16), e: key.e.toString(16)}

rsa.factory "fromPubKey", ["RSAKey", "tap", (RSAKey, tap) ->
  (key) -> tap new RSAKey(), (rsa) -> rsa.setPublic(key.n, key.e)
]
