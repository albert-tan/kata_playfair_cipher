class PlayfairCipher

  def set_table(table)
    @table = table
  end

  def encrypt(message)
    message = sanitize_message(message)
    message = pad_duplicate(message)

    encrypted_digraphs = map_digraphs(message) { |d| encrypt_digraph(d) }
    encrypted_digraphs.join("")
  end

  private

  def sanitize_message(message)
    @table.preprocess_text(message)
  end

  def map_digraphs(message)
    message.scan(/../).map do |digraph|
      yield digraph
    end
  end

  def pad_duplicate(message)
    index = 0
    while index < message.length
      message = message.insert(index + 1, 'X') if message[index] == message[index + 1]
      index += 2
    end
    if (message.length % 2) == 1
      message + 'Z'
    else
      message
    end
  end

  def encrypt_digraph(digraph)
    x1, y1 = @table.get_pos(digraph[0])
    x2, y2 = @table.get_pos(digraph[1])

    encrypt_digraph_if_in_same_column(x1, x2, y1, y2) ||
    encrypt_digraph_if_in_same_row(x1, x2, y1, y2)    ||
    encrypt_digraph_if_in_rectangle(x1, x2, y1, y2)
  end

  def encrypt_digraph_if_in_same_column(x1, x2, y1, y2)
    if x1 == x2
      y1, y2 = [
        wrap_value(y1 + 1, 0, 4),
        wrap_value(y2 + 1, 0, 4)
      ]
      return @table.get_char(x1, y1) + @table.get_char(x2, y2)
    end
  end

  def encrypt_digraph_if_in_same_row(x1, x2, y1, y2)
    if y1 == y2
      x1, x2 = [
        wrap_value(x1 + 1, 0, 4),
        wrap_value(x2 + 1, 0, 4)
      ]
      return @table.get_char(x1, y1) + @table.get_char(x2, y2)
    end
  end

  def encrypt_digraph_if_in_rectangle(x1, x2, y1, y2)
      x1, x2 = x2, x1
      return @table.get_char(x1, y1) + @table.get_char(x2, y2)
  end

  def wrap_value(value, min, max)
    if value > max
      min
    elsif value < min
      max
    else
      value
    end
  end
end
