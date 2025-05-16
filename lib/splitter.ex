defmodule Splitter do
  @moduledoc """
  This module provides a splitting function which implements the behavior described in the SplitString Kata:
  solution("a") # should return ["a_"]
  solution("ab") # should return ["ab"]
  solution("abc") # should return ["ab", "c_"]
  solution("abcdef") # should return ["ab", "cd", "ef"]

  Each implementation step resulting from the TDD approach is represented by a specific private function.
  """

  def split(text) do
    split_5(text, [])
  end

  defp split_1(text), do: [text <> "_"]

  defp split_2(text) do
    if String.length(text) == 1 do
      [text <> "_"]
    else
      [text]
    end
  end

  defp split_2_refactored(text) do
    if String.length(text) == 1 do
      split_one_letter_string text
    else
      split_two_letters_string text
    end
  end

  defp split_one_letter_string(text), do: [text <> "_"]
  defp split_two_letters_string(text), do: [text]

  defp split_3(text) do
    cond do
      String.length(text) == 1 -> split_one_letter_string text
      String.length(text) == 2 -> split_two_letters_string text
      true -> split_two_letters_string(String.slice(text, 0..1)) ++ split_one_letter_string(String.last(text))
    end
  end

  defp split_4(text) do
    cond do
      String.length(text) == 1 -> split_one_letter_string text
      String.length(text) == 2 -> split_two_letters_string text
      true ->
        split_two_letters_string(String.slice(text, 0..1)) ++ split_4(String.slice(text, 2..(String.length(text) - 1)))
    end
  end

  defp split_4_refactored(text) do
    length = String.length(text)
    cond do
      length == 1 -> split_one_letter_string text
      length == 2 -> split_two_letters_string text
      true -> split_4_refactored(String.slice(text, 0..1)) ++ split_4_refactored(String.slice(text, 2..(length - 1)))
    end
  end

  defp split_5(text, acc) do
    length = String.length(text)
    cond do
      text == "" -> acc
      length == 1 -> split_5("", acc ++ split_one_letter_string(text))
      length == 2 -> split_5("", acc ++ split_two_letters_string(text))
      true -> split_5(String.slice(text, 2..(length - 1)), acc ++ split_two_letters_string(String.slice(text, 0..1)))
    end
  end

end
