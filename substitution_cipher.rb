module SubstitutionCipher
  module Caeser
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using caeser cipher
      document.to_s.chars.map{ |x| x.ord + key }
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using caeser cipher
      document.map{ |x| (x.ord - key).chr }.join
    end
  end

  module Permutation
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    
    def self.fill_book(k, r, c)
      begin
        a = r.rand(128)
        c[k] = a unless c.value?(a)
      end until c.key?(k)
    end
    
    def self.encrypt(document, key)
      # TODO: encrypt string using a permutation cipher
      code_book = Hash.new()
      rand1 = Random.new(key)
      (32..127).each do |x|
        fill_book(x, rand1, code_book)
      end
      document.to_s.chars.map{ |x| code_book[x.ord] }
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using a permutation cipher
      code_book = Hash.new()
      rand1 = Random.new(key)
      (32..127).each do |x|
        fill_book(x, rand1, code_book)
      end
      document.map{ |x| (code_book.key(x)).chr }.join
    end
  end
end
