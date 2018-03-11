defmodule Othello.Game do

  def new do
    %{
      tiles: getTiles(),
      is_player1: true,
      p1_score: 0,
      p2_score: 0,
    }
  end
  
  def client_view(game) do
    %{
      tiles: game.tiles,
      is_player1: game.is_player1,
      p1_score: game.p1_score,
      p2_score: game.p2_score,
    }
  end

  def getTiles do
    tiles = for indx <- 0..63 do
              %{
                index: indx,
                val: 0,
              }     
            end

    x = Map.put(Enum.at(tiles, 27), :val, 1)
    tiles = List.delete_at(tiles, 27)
    tiles = List.insert_at(tiles, 27 , x)

    y = Map.put(Enum.at(tiles, 28), :val, 2)
    tiles = List.delete_at(tiles, 28)
    tiles = List.insert_at(tiles, 28 , y)

    z = Map.put(Enum.at(tiles, 36), :val, 1)
    tiles = List.delete_at(tiles, 36)
    tiles = List.insert_at(tiles, 36 , z)

    k = Map.put(Enum.at(tiles, 35), :val, 2)
    tiles = List.delete_at(tiles, 35)
    tiles = List.insert_at(tiles, 35 , k)

  end

  def restart() do
    new()
  end

  def flipback(state) do
       
  end
  
  def playing(state, tile) do    
    tiles = state.tiles
    is_player1 = state.is_player1
    if tile["val"] == 0 do
      i = tile["index"]

      if is_player1 == true do
        x = Map.put(Enum.at(tiles, i), :val, 1)
        tiles = List.delete_at(tiles, i)
        tiles = List.insert_at(tiles, i , x) 
        state = Map.put(state, :tiles, tiles)
        state = Map.put(state, :is_player1, false)

      else
        z = Map.put(Enum.at(tiles, i), :val, 2)
        tiles = List.delete_at(tiles, i)
        tiles = List.insert_at(tiles, i , z) 
        state = Map.put(state, :tiles, tiles)
        state = Map.put(state, :is_player1, true)
      end

    else
      state = state   
    end  

  end
end
