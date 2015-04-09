require 'openssl'
require 'json'
require 'digest/md5'

module AesCipher
  def self.encrypt(document, key)
    # TODO: Return JSON string of array: [iv, ciphertext]
    #       where iv is the random intialization vector used in AES
    #       and ciphertext is the output of AES encryption
    # NOTE: Use hexadecimal strings for output so that it is screen printable
    #       Use cipher block chaining mode only!
    document = document.to_s
    cipher = OpenSSL::Cipher::AES.new(256, :CBC)
    cipher.encrypt
    cipher.key = Digest::MD5.hexdigest(key.to_s)
    iv = cipher.random_iv
    encrypted = (cipher.update(document) + cipher.final)
    my_hash = {
      iv: iv.unpack('H*'), ciphertext: encrypted.unpack('H*')
    }
    JSON.generate(my_hash)
  end

  def self.decrypt(aes_crypt, key)
    # TODO: decrypt from JSON output (aes_crypt) of encrypt method above
    decipher = OpenSSL::Cipher::AES.new(256, :CBC)
    decipher.decrypt
    # decipher.padding = 0
    decipher.key = (Digest::MD5.hexdigest(key.to_s))
    aes_crypt = JSON.parse(aes_crypt)
    decipher.iv = aes_crypt['iv'].pack('H*')
    dec_t = aes_crypt['ciphertext'].pack('H*')
    decipher.update(dec_t) + decipher.final
  end
end
