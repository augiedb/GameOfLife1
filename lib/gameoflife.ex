defmodule Gameoflife do

  :random.seed(:os.timestamp)
  @size 10
  @times 100
  @live_start 20

  def init do
      create_empty_board
      |> add_live_cells # Percent of cells are live
  end

  defp create_empty_board do
    for x <- 1..@size, y <- 1..@size, 
        do: {{x,y}, "."}, 
      into: HashDict.new
  end

  defp add_live_cells(board) do

    total = @size * @size
    live_squares_wanted = round( (@live_start / 100) * total)
    add_live_square(board, live_squares_wanted, 1)
 
  end

  def add_live_square(board, portion, portion) do
    board
  end

  def add_live_square(board, portion, acc) do
    x = :random.uniform(@size)    
    y = :random.uniform(@size)    
    board = HashDict.put(board, {x,y}, "*")
    add_live_square(board, portion, acc+1)
  end




  def play_a_game(@times) do
    Gameoflife.init
    |> do_play_a_game(1) # Start at 1
  end

  def do_play_a_game(board, @times) do
    board 
    |> run_through_cells
    |> display_board 
    # THE END
  end

  def do_play_a_game(board, acc) do
    board 
    |> run_through_cells
    |> display_board 
    |> do_play_a_game(acc+1)
  end

  def run_through_cells(board) do
   # for x <- 1..@size, do:
   #    do: new_board = update_cell(board, {x,y}) 
   board
  end

  def display_board(board) do
   IO.ANSI.clear
   for x <- 1..@size, do:
       IO.puts get_row(board, x) 
  end

  def get_row(board, row) do
    do_get_row(board, row, 1, "")
  end
  
  defp do_get_row(_, _, @size + 1, show_row), do: show_row

  defp do_get_row(board, row, column, show_row) do
    show_row = show_row <> HashDict.get(board, {row, column})
    do_get_row(board, row, column + 1, show_row) 
  end




  def next_move(board, x, y) do
     new_board = Gameoflife.init()
     case(HashDict.get(board, {x,y}) ) do
        1 -> IO.puts "WAIT" 
        0 -> check_dead_cell(board, new_board, {x, y})
     end
  end

  def check_dead_cell(board, new_board, {x, y}) do
  end

end

