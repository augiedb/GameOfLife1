defmodule Gameoflife do

  :random.seed(:os.timestamp)
  @size 32 
  @times 100 
  @live_start 20

  def init do
      create_empty_board
      |> add_live_cells # Percent of cells are live
  end

  defp create_empty_board do
    for x <- 0..(@size+1), y <- 0..(@size+1), 
        do: {{x,y}, "."}, 
      into: HashDict.new
  end

  defp add_live_cells(board) do
    total = @size * @size
    live_squares_wanted = round( (@live_start / 100) * total)
    add_live_square(board, live_squares_wanted + 2, 1)
  end

  def add_live_square(board, portion, portion) do
    board
  end

  def add_live_square(board, portion, acc) do
    :random.seed(:os.timestamp)
    x = :random.uniform(@size)    
    y = :random.uniform(@size)    
    case HashDict.get(board, {x,y}) do
      "*" -> add_live_square(board, portion, acc)
      "." -> board = HashDict.put(board, {x,y}, "*")   
    end
    add_live_square(board, portion, acc+1)
  end




  def play_a_game do
    Gameoflife.init
    |> display_board
    |> do_play_a_game(1) # Start at 1
  end

  def do_play_a_game(board, @times) do
    board 
    |> run_through_cells
    |> display_board 
    IO.puts "THE END"
  end

  def do_play_a_game(board, acc) do
    board 
    |> run_through_cells
    |> display_board 
    |> do_play_a_game(acc+1)
  end

  def run_through_cells(board) do
    do_run_through_cells(board, 1, 1, Gameoflife.init)
  end

  # You've fallen off the bottom of the board
  def do_run_through_cells(_, @size+1, _, new_board) do
    new_board
  end 

  # Next row after this one
  def do_run_through_cells(board, x, y, new_board) when y == @size do
    new = new_cell_value(board, {x,y})
    new_board = HashDict.put(new_board, {x, y}, new)
    do_run_through_cells(board, x+1, 1, new_board)
  end

  # Next!
  def do_run_through_cells(board, x, y, new_board) do
    new = new_cell_value(board, {x,y})
    new_board = HashDict.put(new_board, {x, y}, new)
    do_run_through_cells(board, x, y+1, new_board)
  end

  def new_cell_value(board, {x, y}) do
     case HashDict.get(board, {x,y}) do
        "*" -> check_live_cell(board, {x, y})
        "." -> check_dead_cell(board, {x, y})
     end
  end

  def check_dead_cell(board, {x, y}) do
    live = live_cells_surrounding(board, {x, y})
    case live do
      3 -> "*"
      _ -> "."
    end
  end

  def check_live_cell(board, {x, y}) do
    live = live_cells_surrounding(board, {x,y})
    case live do
      2 -> "*"
      3 -> "*"
      _ -> "."
    end
  end


  def live_cells_surrounding(board, {x, y}) do
    live = 0
    if ( HashDict.get(board, {x+1, y}) == "*" ), do: live = live + 1
    if ( HashDict.get(board, {x-1, y}) == "*" ), do: live = live + 1
    if ( HashDict.get(board, {x, y+1}) == "*" ), do: live = live + 1
    if ( HashDict.get(board, {x, y-1}) == "*" ), do: live = live + 1
    if ( HashDict.get(board, {x+1, y+1}) == "*" ), do: live = live + 1
    if ( HashDict.get(board, {x+1, y-1}) == "*" ), do: live = live + 1
    if ( HashDict.get(board, {x-1, y+1}) == "*" ), do: live = live + 1
    if ( HashDict.get(board, {x-1, y-1}) == "*" ), do: live = live + 1
    live
  end




## DISPLAY BOARD

  def display_board(board) do
   for x <- 1..@size, do:
       IO.puts get_row(board, x) 
   IO.puts "----------"
   board
  end

  def get_row(board, row) do
    do_get_row(board, row, 1, "")
  end
  
  defp do_get_row(_, _, @size + 1, show_row), do: show_row

  defp do_get_row(board, row, column, show_row) do
    show_row = show_row <> HashDict.get(board, {row, column})
    do_get_row(board, row, column + 1, show_row) 
  end

end

