require "playfair_table"

describe PlayfairTable do

  context "when populating table with 'playfair example' keyword" do

    before :each do
      subject.set_key("playfair example")
    end

    it "fills the keyword into table" do
      # fill keyword letter by letter
      subject.get_char(0, 0).should == 'P'
      subject.get_char(1, 0).should == 'L'
      subject.get_char(2, 0).should == 'A'
      subject.get_char(3, 0).should == 'Y'
      subject.get_char(4, 0).should == 'F'
    end

    it "drop any duplicate letters" do
      # drop duplicate 'A' and insert 'I' instead
      subject.get_char(0, 1).should == 'I'
    end

    it "fills remaining of the table spaces with the rest of the alphabet letters in order" do
      subject.get_char(0, 2).should == 'B'
      subject.get_char(1, 2).should == 'C'
      subject.get_char(2, 2).should == 'D'
      subject.get_char(4, 4).should == 'Z'
    end

    it "puts both letters 'I' and 'J' in the same space" do
      subject.get_pos('I').should == subject.get_pos('J')
      subject.get_char(0, 3).should == 'K'
    end

    it "returns a letter position in table" do
      subject.get_pos('P').should == [0, 0]
      subject.get_pos('L').should == [1, 0]
      #
      chars = ('A'..'Z').to_a - ['J']
      chars.each do |char|
        subject.get_char(*subject.get_pos(char)).should == char
      end
    end

  end

  it "preprocess text to strip all unsupported characters and capitalize all characters" do
    subject.preprocess_text("A+-\|/B!@$%^&*( )C").should == "ABC"
  end

end
