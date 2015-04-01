module SubstitutionCipher
  module Caeser
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using caeser cipher
      document.to_s.chars.map { |x| x.ord + key }
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using caeser cipher
      document.map { |x| (x.ord - key).chr }.join
    end
  end

  module Permutation
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String

    def self.fill_book(key, cb)
      # Fill code book
      def self.int_loop(key, r, c)
        # Iterator to create unique random values
        loop do
          a = r.rand(128)
          c[key] = a unless c.value?(a)
          break if c.key?(key)
        end
      end
      rand1 = Random.new(key)
      (32..127).each do |x|
        int_loop(x, rand1, cb)
      end
      cb
    end

    def self.encrypt(document, key)
      # TODO: encrypt string using a permutation cipher
      code_book = {}
      fill_book(key, code_book)
      document.to_s.chars.map { |x| code_book[x.ord] }
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using a permutation cipher
      code_book = {}
      fill_book(key, code_book)
      document.map { |x| (code_book.key(x)).chr }.join
    end
  end
end
