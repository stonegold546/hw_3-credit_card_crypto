module DoubleTranspositionCipher
  require 'matrix'
  def self.shuffle(num, my_rand) # deterministic replacement sequence method
    (0...num).to_a.shuffle(random: my_rand)
  end

  def self.generic_att(document, key) # attributes needed for encryot/decrypt
    nc = Math.sqrt(document.length).round
    doc_multi_arr = document.chars.each_slice(nc).to_a
    nr = doc_multi_arr.length
    rand_1 = Random.new(key)
    row_a = shuffle(nr, rand_1)
    col_a = shuffle(nc, rand_1)
    [row_a, col_a, doc_multi_arr, nc, nr]
  end

  def self.pad_multi_arr(multi_arr, nc)
    # pad multi array with values to allow for matrix manipulation
    (0...nc).to_a.each do |idx|
      multi_arr.last[idx] = 0.chr if multi_arr.last[idx].nil?
    end
    multi_arr
  end

  def self.matrix_swap(my_mat, swap_arr, nr)
    new_mat = Matrix[]
    (0...nr).to_a.each_index do |idx|
      new_mat = Matrix.rows(new_mat.to_a << my_mat.row(swap_arr[idx]))
    end
    new_mat
  end

  def self.matrix_row_col_swap(my_mat, swap_row, swap_col, nr, nc)
    my_mat = matrix_swap(my_mat, swap_row, nr).transpose
    matrix_swap(my_mat, swap_col, nc).transpose
  end

  def self.matrix_dec_swap(my_mat, swap_arr, nr)
    interm_arr = [[]]
    (0...nr).to_a.each_index do |idx|
      interm_arr[swap_arr[idx]] = my_mat.row(idx).to_a
    end
    Matrix.rows(interm_arr)
  end

  def self.matrix_dec_row_col_swap(my_mat, swap_row, swap_col, nr, nc)
    my_mat = matrix_dec_swap(my_mat.transpose, swap_col, nc).transpose
    matrix_dec_swap(my_mat, swap_row, nr)
  end

  def self.encrypt(document, key)
    document = document.to_s
    row_s, col_s, doc_multi_arr, nc, nr = *generic_att(document, key)
    doc_multi_arr = pad_multi_arr(doc_multi_arr, nc)
    my_mat = Matrix.rows(doc_multi_arr)
    cipher = matrix_row_col_swap(my_mat, row_s, col_s, nr, nc)
    cipher.to_a.join
  end

  def self.decrypt(document, key)
    row_s, col_s, doc_multi_arr, nc, nr = *generic_att(document, key)
    cipher_mat = Matrix.rows(doc_multi_arr)
    doc_mat = matrix_dec_row_col_swap(cipher_mat, row_s, col_s, nr, nc)
    doc_mat.to_a.join.tr(0.chr, '')
  end
end
