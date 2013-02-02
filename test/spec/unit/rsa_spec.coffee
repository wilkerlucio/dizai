describe "RSA Module", ->
  beforeEach -> module("rsa")

  describe "Extended RSAKey object", ->
    rsa = null
    beforeEach inject (RSAKey) -> rsa = new RSAKey()

    it "calculates the decode chunk size", ->
      rsa.generate(1024, "10001")
      expect(rsa.chunkDecodeSize()).toBe(256)
      rsa.generate(512, "10001")
      expect(rsa.chunkDecodeSize()).toBe(128)

    it "calculates the encode chunk size", ->
      rsa.generate(1024, "10001")
      expect(rsa.chunkEncodeSize()).toBe(117)
      rsa.generate(512, "10001")
      expect(rsa.chunkEncodeSize()).toBe(53)

    describe "encode and decode", ->
      it "an one chunk sized content", ->
        rsa.generate(1024, "10001")
        text = "sample text"
        expect(rsa.decrypt(rsa.encrypt(text))).toEqual(text)

      it "an multiple size chunk sized content", ->
        rsa.generate(1024, "10001")
        text = "sample text sample text sample text sample text sample text sample text sample text sample text sample text sample text "
        expect(rsa.decrypt(rsa.encrypt(text))).toEqual(text)

  it "generate a key on the fly", inject (RSAKey, keygen) ->
    expect(keygen()).toEqual(jasmine.any(RSAKey))

  it "can convert a pubkey, encode and decode from it", inject (keygen, toPubKey, fromPubKey) ->
    string = "sample"
    key = keygen()
    pub = toPubKey(key)
    pubKey = fromPubKey(pub)
    encoded = pubKey.encrypt(string)
    expect(key.decrypt(encoded)).toEqual(string)
