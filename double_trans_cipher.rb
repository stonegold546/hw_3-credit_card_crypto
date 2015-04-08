module DoubleTranspositionCipher
  require 'matrix'
  def self.encrypt(document, key)
    # TODO: FILL THIS IN!
    ## Suggested steps for double transposition cipher
    # 1. find number of rows/cols such that matrix is almost square
    # 2. break plaintext into evenly sized blocks
    # 3. sort rows in predictably random way using key as seed
    # 4. sort columns of each row in predictably random way
    # 5. return joined cyphertext
    document = document.to_s
    nc = Math.sqrt(document.length).round
    doc_arr = document.chars.each_slice(nc).to_a
    nr = doc_arr.length
    rand1 = Random.new(key)
    row_a = (0...nr).to_a.shuffle(random: rand1)
    ciph_arr = [[]]
    x = 0
    doc_arr.each do
      ciph_arr << doc_arr[row_a[x]]
      x += 1
    end
    col_a = (0...nc).to_a.shuffle(random: rand1)
    ciph_arr.flatten!
    lth = col_a.length
    ciph_int = []
    ciph_arr.each_index do |idx|
      mod = idx % lth
      div = idx / lth
      b = div * lth + col_a[mod]
      ciph_int[b] = ciph_arr[idx]
    end
    ciph_int.join
  end

  def self.decrypt(ciphertext, key)
    # TODO: FILL THIS IN!
    nc = Math.sqrt(ciphertext.length).round
    ciph_arr = ciphertext.chars
    nr = ciph_arr.each_slice(nc).to_a.length
    rand1 = Random.new(key)
    row_a = (0...nr).to_a.shuffle(random: rand1)
    col_a = (0...nc).to_a.shuffle(random: rand1)
    lth = col_a.length
    ciph_int = []
    ciph_arr.each_index do |idx|
      mod = idx % lth
      div = idx / lth
      b = div * lth + col_a[mod]
      ciph_int[idx] = ciph_arr[b]
    end
    x = 0
    ciph_text = ciph_int.each_slice(nc).to_a
    org_doc = [[]]
    ciph_text.each do
      org_doc[row_a[x]] = ciph_text[x]
      x += 1
    end
    org_doc.join
  end
end
