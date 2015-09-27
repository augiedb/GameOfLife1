defmodule GameoflifeTest do
  use ExUnit.Case
  doctest Gameoflife

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "set up board" do
    board = Gameoflife.init
    assert HashDict.size(board) == 144
  end

  test "Board prints out correctly" do
   # board = Gameoflife.init
#    assert Gameoflife.get_row(board, 1) == "0000000000" 
#    assert Gameoflife.display_board(board) = "notgonnawork"
  end

  test "Test cell changes" do
    sample_cell = Gameoflife.init
    sample_cell = HashDict.put(sample_cell, {0, 0 }, ".")
    sample_cell = HashDict.put(sample_cell, {0, 1 }, ".")
    sample_cell = HashDict.put(sample_cell, {0, 2 }, ".")

    sample_cell = HashDict.put(sample_cell, {1, 0 }, ".")
    sample_cell = HashDict.put(sample_cell, {1, 1 }, ".")
    sample_cell = HashDict.put(sample_cell, {1, 2 }, ".")

    sample_cell = HashDict.put(sample_cell, {2, 0 }, ".")
    sample_cell = HashDict.put(sample_cell, {2, 1 }, ".")
    sample_cell = HashDict.put(sample_cell, {2, 2 }, ".")

    assert Gameoflife.new_cell_value(sample_cell, {1,1}) == "."
    sample_cell = HashDict.put(sample_cell, {1, 1 }, "*")
    assert Gameoflife.new_cell_value(sample_cell, {1,1}) == "."

    sample_cell = HashDict.put(sample_cell, {1, 0 }, "*")
    sample_cell = HashDict.put(sample_cell, {1, 1 }, ".")
    sample_cell = HashDict.put(sample_cell, {1, 2 }, "*")
    sample_cell = HashDict.put(sample_cell, {2, 1 }, "*")

    assert Gameoflife.new_cell_value(sample_cell, {1,1}) == "*"
    
  end

   
end
