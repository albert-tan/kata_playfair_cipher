class PlayfairTable

  def set_key(key_phrase)
    @map_by_pos = Array.new(5) { Array.new(5) }
    @map_by_char = {}

    key_phrase = key_phrase.upcase
    char_candidates = ('A'..'Z').to_a
    char_candidates.delete('J')

    key_phrase.each_char do |char|
      add_table_entry(char) if char_candidates.delete(char)
    end

    char_candidates.each do |char|
      add_table_entry(char)
    end

    # put 'J' into same space as 'I'
    @map_by_char['J'] = @map_by_char['I']
  end

  def preprocess_text(text)
    text.upcase.delete("^" + ('A'..'Z').to_a.join)
  end

  def get_char(x, y)
    @map_by_pos[y][x]
  end

  def get_pos(char)
    @map_by_char[char]
  end

  private

  def add_table_entry(char)
    x = @map_by_char.length % 5
    y = @map_by_char.length / 5
    @map_by_char[char] = [x, y]
    @map_by_pos[y][x] = char
  end
  
end
