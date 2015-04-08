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
    ciph_arr.join
=begin
    col_a = (0...nc).to_a.shuffle(random: rand1)
    ciph_arr.flatten!
    lth = col_a.length
    ciph_arr.each_index do |idx|
      mod = idx % lth
      div = idx / lth
      ciph_arr[idx], ciph_arr[div * lth + col_a[mod]] = ciph_arr[div * lth + col_a[mod]], ciph_arr[idx]
    end
=end
=begin
    (0...lth).to_a.each do |idx|
      row_a.each do |x_idx|
        if x_idx == 0
          ciph_arr[idx], ciph_arr[col_a[idx]] = ciph_arr[col_a[idx]], ciph_arr[idx]
        else
          ciph_arr[x_idx * idx], ciph_arr[x_idx * col_a[idx]] = ciph_arr[x_idx * col_a[idx]], ciph_arr[x_idx * idx]
        end
      end
    end
=end
    ciph_arr.join
  end

  def self.decrypt(ciphertext, key)
    # TODO: FILL THIS IN!
    nc = Math.sqrt(ciphertext.length).round
    ciph_arr = ciphertext.chars
    nr = ciph_arr.each_slice(nc).to_a.length
    rand1 = Random.new(key)
    row_a = (0...nr).to_a.shuffle(random: rand1)
    col_a = (0...nc).to_a.shuffle(random: rand1)
=begin
    lth = col_a.length
    ciph_arr.each_index do |idx|
      mod = idx % lth
      div = idx / lth
      ciph_arr[idx], ciph_arr[div * lth + col_a[mod]] = ciph_arr[div * lth + col_a[mod]], ciph_arr[idx]
    end
=end
    x = 0
    ciph_text = ciph_arr.each_slice(nc).to_a
    org_doc = [[]]
    ciph_text.each do
      org_doc[row_a[x]] = ciph_text[x]
      x += 1
    end
    org_doc.join
  end
end
