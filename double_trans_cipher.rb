# Double Transposition Cipher
module DoubleTranspositionCipher
  def self.get_gen_att(my_doc, my_rand)
    n_col = Math.sqrt(my_doc.length).round
    my_doc_arr = my_doc.chars.each_slice(nc).to_a
    n_row = my_doc_arr.length
    row_s = (0...nr).to_a.shuffle(random: my_rand)
    col_s = (0...nc).to_a.shuffle(random: my_rand)
    [row_s, col_s, n_col, n_row, my_doc_arr]
  end

  def self.encrypt(document, key)
    document = document.to_s
    nc = Math.sqrt(document.length).round
    doc_arr = document.chars.each_slice(nc).to_a # Multidimensional array
    nr = doc_arr.length
    rand1 = Random.new(key)
    row_a = (0...nr).to_a.shuffle(random: rand1) # Row swap - new positions
    col_a = (0...nc).to_a.shuffle(random: rand1) # Col swap - new positions
    ciph_arr = [[]]
    doc_arr.each_index do |idx|
      ciph_arr << doc_arr[row_a[idx]]
    end # Creates new array shifted by rows
    ciph_arr.flatten!
    lth = col_a.length
    ciph_int = []
    ciph_arr.each_index do |idx|
      mod = idx % lth
      div = idx / lth
      b = div * lth + col_a[mod]
      ciph_int[b] = ciph_arr[idx]
      loop do
        # Necessary to ensure last line is fully swapped
        # Replacing with nulls
        idx += 1
        mod = idx % lth
        div = idx / lth
        b = div * lth + col_a[mod]
        break if mod == 0
        ciph_int[b] = 0.chr
      end if idx == document.length - 1
      # Swaps based on col_swap by each index
      # Using index as column manipulation proving to be difficult
      # Alternatively, could create matrix for easier manipulation,
      # fill with nil to make square, then swap rows and columns
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
      if ciph_arr[b] == 0.chr
        ciph_int[idx] = ''
      else
        ciph_int[idx] = ciph_arr[b]
      end
    end
    ciph_text = ciph_int.each_slice(nc).to_a
    org_doc = [[]]
    ciph_text.each_index do |idx|
      org_doc[row_a[idx]] = ciph_text[idx]
    end
    org_doc.join
  end
end
