require "playfair_cipher"
require "playfair_table"

describe PlayfairCipher do

  context "when table key is 'playfair example'" do

    let(:test_table) do
      table = PlayfairTable.new
      table.set_key("playfair example")
      table
    end

    before :each do
      subject.set_table(test_table)
    end

    it "insert 'X' for any diagraph that has the same letter" do
      subject.encrypt("AAB").should == subject.encrypt("AXAB")
      subject.encrypt("AAAB").should == subject.encrypt("AXAXAB")
      subject.encrypt("BAA").should == subject.encrypt("BAAZ")
    end

    it "appends 'Z' if needed to complete the final diagraph" do
      subject.encrypt("A").should == subject.encrypt("AZ")
    end

    context "when digraph form a rectangle" do

      it "picks the character from the same row but opposite corner" do
        subject.encrypt("HI").should == "BM"
        subject.encrypt("CW").should == "GU"
      end

    end

    context "when digraph form a single column" do

      it "picks items below each letter" do
        subject.encrypt("DE").should == "OD"
      end
 
      it "picks items below each letter and wrap to top if needed" do
        subject.encrypt("YW").should == "XY"
      end

    end

    context "when digraph form a single row" do

      it "picks items right to each letter" do
        subject.encrypt("EX").should == "XM"
      end
 
      it "picks items right to each letter and wrap to left if needed" do
        subject.encrypt("KS").should == "NK"
      end

    end

    it "encrpyts message" do
      subject.encrypt("Hide the gold in the tree stump").should == "BMODZBXDNABEKUDMUIXMMOUVIF"
    end

  end

end
