defmodule SplitterTest do
  use ExUnit.Case, asynch: true
  use PropCheck
  alias Randomizer
  doctest Splitter

  describe "Specific" do
    test "when string is a then result is a singleton list with string a_" do
      assert Splitter.split("a") == ["a_"]
    end

    test "when string is ab then result is a singleton list with string ab" do
      assert Splitter.split("ab") == ["ab"]
    end

    test "when string is abc then result is a list composed of strings ab and c_" do
      assert Splitter.split("abc") == ["ab", "c_"]
    end

    test "when string is abcd then result is a list composed of strings ab and cd" do
      assert Splitter.split("abcd") == ["ab", "cd"]
    end

    test "when string is abcde then result is a list composed of strings ab and cd and e_" do
      assert Splitter.split("abcde") == ["ab", "cd", "e_"]
    end

    test "when string is abcdef then result is a list composed of strings ab and cd and ef" do
      assert Splitter.split("abcdef") == ["ab", "cd", "ef"]
    end
  end

  describe "Property-based" do
    property "The splitting concatenates the result obtained from first two letters with the result obtained from remaining string",
             [:verbose] do
      forall length <- choose(3, 20) do
        text = Randomizer.randomizer(length, :alpha)
        assert Splitter.split(text) ==
           Splitter.split(String.slice(text, 0..1)) ++
           Splitter.split(String.slice(text, 2..(length - 1)))
      end
    end
  end

end
