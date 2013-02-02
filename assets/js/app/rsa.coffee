rsa = angular.module("rsa", [])

rsa.factory "RSAKey", ->
  class RSAKeyExtended extends RSAKey
    chunkDecodeSize: -> @n.toString(16).length
    chunkEncodeSize: -> Math.floor(@chunkDecodeSize() / 2) - 11

    encrypt: (string) ->
      encrypted = ""
      size = @chunkEncodeSize()
      chunks = Math.ceil(string.length / size)

      for i in [0...chunks]
        x = i * size
        chunk = string.substr(x, size)
        encrypted += super(chunk)

      hex2b64(encrypted)

    decrypt: (string) ->
      string = b64tohex(string)
      decrypted = ""
      size = @chunkDecodeSize()
      chunks = string.length / size

      for i in [0...chunks]
        x = i * size
        chunk = string.substr(x, size)
        decrypted += super(chunk)

      decrypted

rsa.factory "keygen", ["RSAKey", (RSAKey) ->
  (bits = 1024, exponent = "10001") ->
    rsa = new RSAKey()
    rsa.generate(bits, exponent)
    rsa
]

rsa.factory "toPubKey", ->
  (key) -> {n: key.n.toString(16), e: key.e.toString(16)}

rsa.factory "fromPubKey", ->
  (key) ->
    rsa = new RSAKey()
    rsa.setPublic(key.n, key.e)
    rsa
