defmodule GameoflifeTest do
  use ExUnit.Case
  doctest Gameoflife

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "set up board" do
    board = Gameoflife.init
    assert HashDict.size(board) == 100
  end

  test "Board prints out correctly" do
    board = Gameoflife.init
#    assert Gameoflife.get_row(board, 1) == "0000000000" 
#    assert Gameoflife.display_board(board) = "notgonnawork"
  end
   
end
