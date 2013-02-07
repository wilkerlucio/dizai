describe "RSA Module", ->
  beforeEach -> module("rsa")

  describe "Extended RSAKey object", ->
    rsa = null
    beforeEach inject (RSAKey) -> rsa = new RSAKey()

    it "calculates the decode chunk size", ->
      rsa.generate(128, "10001")
      expect(rsa.chunkDecodeSize()).toBe(32)
      rsa.generate(64, "10001")
      expect(rsa.chunkDecodeSize()).toBe(16)

    it "calculates the encode chunk size", ->
      rsa.generate(256, "10001")
      expect(rsa.chunkEncodeSize()).toBe(21)
      rsa.generate(128, "10001")
      expect(rsa.chunkEncodeSize()).toBe(5)

    describe "encode and decode", ->
      it "an one chunk sized content", ->
        rsa.generate(256, "10001")
        text = "sample text"
        expect(rsa.decrypt(rsa.encrypt(text))).toEqual(text)

      it "an multiple size chunk sized content", ->
        rsa.generate(128, "10001")
        text = "1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50"
        encoded = rsa.encrypt(text)
        decoded = rsa.decrypt(encoded)

        expect(decoded).toEqual(text, encoded.length)

  it "generate a key on the fly", inject (RSAKey, keygen) ->
    expect(keygen()).toEqual(jasmine.any(RSAKey))

  it "can convert a pubkey, encode and decode from it", inject (keygen, toPubKey, fromPubKey) ->
    string = "sample"
    key = keygen()
    pub = toPubKey(key)
    pubKey = fromPubKey(pub)
    encoded = pubKey.encrypt(string)
    expect(key.decrypt(encoded)).toEqual(string)
