defmodule Othello.Game do

  def new do
    %{
      tiles: getTiles(),
      is_player1: true,
      player1: nil,
      player2: nil,
      spectators: [],
      player_count: 0,
      p1_score: 2,
      p2_score: 2,
      winner: 0,
      pos1: true,
      pos2: true,
      alert_message: " "
    }
  end
  
  def client_view(game) do
    %{
      tiles: game.tiles,
      is_player1: game.is_player1,
      player1: game.player1,
      player2: game.player2,
      spectators: game.spectators,
      player_count: game.player_count,
      p1_score: game.p1_score,
      p2_score: game.p2_score,
      winner: game.winner,
      pos1: game.pos1,
      pos2: game.pos2,
      alert_message: game.alert_message
    }
  end

  def playerupdate(state, playername, player_count) do

    if state.player1 == nil do
      player1 = playername
      state = Map.put(state, :player1, player1)
      state = Map.put(state, :player_count, player_count)
      state = Map.put(state, :alert_message, "Player 1 has joined! Waiting for Player 2!")
    else
      if state.player2 == nil do
        player2 = playername
        state = Map.put(state, :player2, player2)
        state = Map.put(state, :player_count, player_count)
        state = Map.put(state, :alert_message, "Player 2 has joined! Now you can start playing!")
      else
        spectators = state.spectators
        new_spectators = List.insert_at(spectators,state.player_count,playername)
        alert_message = playername <> " has joined as a spectator!"
        state = Map.put(state, :alert_message, alert_message)
        state = Map.put(state, :spectators, new_spectators)
        state = Map.put(state, :player_count, player_count)
      end
    end 
  end


  def getTiles do
    tiles = for indx <- 0..63 do
              %{
                index: indx,
                val: 0,
              }     
            end

    x = Map.put(Enum.at(tiles, 27), :val, 2)
    tiles = List.delete_at(tiles, 27)
    tiles = List.insert_at(tiles, 27 , x)

    y = Map.put(Enum.at(tiles, 28), :val, 1)
    tiles = List.delete_at(tiles, 28)
    tiles = List.insert_at(tiles, 28 , y)

    z = Map.put(Enum.at(tiles, 36), :val, 2)
    tiles = List.delete_at(tiles, 36)
    tiles = List.insert_at(tiles, 36 , z)

    k = Map.put(Enum.at(tiles, 35), :val, 1)
    tiles = List.delete_at(tiles, 35)
    tiles = List.insert_at(tiles, 35 , k)

  end

  def restart(state, id) do
    if id == 1 do
      w = 2
    else
      w =1
    end
    state = Map.put(state, :winner, w)
  end

  def quit(state) do
    state = new()
  end

  def attack(state, []) do
    p1_score = state.p1_score
    p2_score = state.p2_score
    is_player1 = state.is_player1
    if state.is_player1 do
      p1_score = p1_score + 1
    else
      p2_score = p2_score + 1
    end
    state = Map.put(state, :p1_score, p1_score)
    state = Map.put(state, :p2_score, p2_score)
  end

  def attack(state, [h | rest]) do
    p1_score = state.p1_score
    p2_score = state.p2_score
    is_player1 = state.is_player1
    if state.is_player1 do
      val = 1
    else
      val = 2
    end
    tiles = state.tiles
    i = h[:index]
    z = Map.put(Enum.at(tiles, i), :val, val)
    if val == 1 do
      p1_score = p1_score + 1
      p2_score = p2_score - 1
    else
      p1_score = p1_score - 1
      p2_score = p2_score + 1
    end

    tiles = List.update_at(tiles, i, fn(t) -> t = z end)
    state = Map.put(state, :tiles, tiles)
    state = Map.put(state, :p1_score, p1_score)
    state = Map.put(state, :p2_score, p2_score)
    attack(state, rest)       
  end

  def getAdjacentEnemies(tile, tiles, val) do
    if tile["index"] == nil do
      i = tile[:index]
    else
      i = tile["index"]
    end

    adjacentTiles = []
  
    if (i-1) >= 0 && rem(i-1, 8) != 7 do
      adjacentTiles = adjacentTiles ++ [Enum.at(tiles, i-1)]
      if (i-9) >= 0 do
        adjacentTiles = adjacentTiles ++ [Enum.at(tiles, i-9)]
      end
      if (i+7) < 63 do
        adjacentTiles = adjacentTiles ++ [Enum.at(tiles, i+7)]
      end
    end

    if rem(i+1, 8) != 0 && i < 63 do
      adjacentTiles = adjacentTiles ++ [Enum.at(tiles, i+1)]
      if rem(i-7, 8) != 0 do
        adjacentTiles = adjacentTiles ++ [Enum.at(tiles, i-7)]
      end
      if rem(i+9, 8) != 0 && (i+9) <= 63 do
        adjacentTiles = adjacentTiles ++ [Enum.at(tiles, i+9)]
      end
    end
    
    if (i+8) <= 63 do
      adjacentTiles = adjacentTiles ++ [Enum.at(tiles, i+8)]
    end

    if (i-8) >= 0 do
      adjacentTiles = adjacentTiles ++ [Enum.at(tiles, i-8)]
    end
    enemies = Enum.filter(adjacentTiles, fn(t) -> t[:val] != 0 &&  t[:val] != val end)
  end
  
  def alternateTile([h | rest], tile, tiles, val) do
    if rest == [] do
      helperDisc(h, tile, tiles, val)
    else
      if helperDisc(h, tile, tiles, val) do
        true
      else
        alternateTile(rest, tile, tiles, val)
      end
    end
  end

  def helperDisc(enemy, tile, tiles, val) do
    if tile["index"] == nil do
      i = tile[:index]
    else
      i = tile["index"]
    end

    d = i - enemy[:index]
    alt = enemy[:index] - d
    e = enemy[:index]
    altTile = %{}
    if alt < 0 || alt > 63 || ((rem(e, 8) == 0 || rem(e, 8) == 7) && d in [1, -1, 7, -7, 9, -9]) do
      altTile = %{}
    else
      altTile = Enum.at(tiles, alt)
    end

    altval = altTile[:val]

    cond do
      altval == 0 -> false
      altval == enemy[:val] -> helperDisc(altTile, enemy, tiles, val)
      altval == val -> true
      true -> false
    end
  end


  def getVisitedTiles([h | rest], tile, tiles, val, visitedTiles) do
    a = []
    if rest == [] do
      visitedTiles = visitedTiles ++ attacklist(h, tile, tiles, val, a)
      
    else
      b = attacklist(h, tile, tiles, val, a)
      visitedTiles = visitedTiles ++ b
      getVisitedTiles(rest, tile, tiles, val, visitedTiles)
    end
  end

  def attacklist(enemy, tile, tiles, val, visitedTiles) do
    if tile["index"] == nil do
      i = tile[:index]
    else
      i = tile["index"]
    end

    d = i - enemy[:index]
    alt = enemy[:index] - d
    e = enemy[:index]
    altTile = %{}
    if alt < 0 || alt > 63 || ((rem(e, 8) == 0 || rem(e, 8) == 7) && d in [1, -1, 7, -7, 9, -9]) do
      altTile = %{}
    else
      altTile = Enum.at(tiles, alt)
    end

    altval = altTile[:val]

    if altval == 0 || altval == nil do
      visitedTiles = []
    else
      if altval == enemy[:val] do
        visitedTiles = visitedTiles ++ [enemy]
        attacklist(altTile, enemy, tiles, val, visitedTiles)
      else
        visitedTiles = visitedTiles ++ [enemy]
      end
    end
  end

  def isAttacking(tile, tiles, val) do
    enemies = getAdjacentEnemies(tile, tiles, val)    
    if length(enemies) >= 1 do
      alternateTile(enemies, tile, tiles, val)
    else
      false
    end
  end

  def checkWinner(state) do
    p1_score = state.p1_score
    p2_score = state.p2_score
    total = p1_score + p2_score
    cond do
      p1_score == 0 -> true
      p2_score == 0 -> true
      total == 64 -> true  
      true -> false
    end
  end 

  def getWinner(state) do
    p1_score = state.p1_score
    p2_score = state.p2_score
    if p1_score == 0 do
      w = 2
    else
      if p2_score == 0 do
        w = 1
      else 
        if p1_score > p2_score do
          w = 1
        else
          w = 2
        end 
      end 
    end

    w
  end   

  def ismovePossible(state, val) do
    tiles = state.tiles
    emptyTiles = Enum.filter(tiles, fn(t) -> t[:val] == 0 end)
    x = for tile <- emptyTiles do
          isAttacking(tile, tiles, val)
        end
  end

  def playing(state, tile, id) do
    if id < 3 and state.winner == 0 and state.player_count >= 2 do
      tiles = state.tiles
      is_player1 = state.is_player1
      if is_player1 do
        val = 1
      else
        val = 2
      end

      if val == id do 

        pos1 = true in ismovePossible(state, 1)
      pos2 = true in ismovePossible(state, 2)

      if tile["val"] == 0 && (pos1 ||  pos2) do
        a = isAttacking(tile, tiles, val)
        if a do
          enemies = getAdjacentEnemies(tile, tiles, val)
          visitedTiles = []
          visitedTiles = List.flatten(getVisitedTiles(enemies, tile, tiles, val, visitedTiles))
          state = attack(state, visitedTiles)
          tiles = state.tiles
          x = checkWinner(state)
          if x do
            w = getWinner(state)
          else
            w=0 
          end
          i = tile["index"]
          if is_player1 do
            if pos1 do
              z = Map.put(Enum.at(tiles, i), :val, 1)
              tiles = List.delete_at(tiles, i)
              tiles = List.insert_at(tiles, i , z) 
              state = Map.put(state, :tiles, tiles)
              state = Map.put(state, :is_player1, false)
              state = Map.put(state, :winner, w)
              state = Map.put(state, :pos1, pos1)
            else
              state = Map.put(state, :is_player1, false)
              state = Map.put(state, :pos1, false)
            end
          else
            if pos2 do
              y = Map.put(Enum.at(tiles, i), :val, 2)
              tiles = List.delete_at(tiles, i)
              tiles = List.insert_at(tiles, i , y) 
              state = Map.put(state, :tiles, tiles)
              state = Map.put(state, :is_player1, true)
              state = Map.put(state, :winner, w)
              state = Map.put(state, :pos2, pos2)
            else
              state = Map.put(state, :is_player1, true)
              state = Map.put(state, :pos2, false)
            end
          end 
        else
          if is_player1 do
            if pos1 do
              state = Map.put(state, :pos1, pos1)
            else
              state = Map.put(state, :is_player1, false)
              state = Map.put(state, :pos1, false)
            end
          else
            if pos2 do
              state = Map.put(state, :pos2, pos2)
            else
              state = Map.put(state, :is_player1, true)
              state = Map.put(state, :pos2, false)
            end
          end
        end
      else
        if tile["val"] != 0 do
          if !pos1 && !pos2 do
            w = getWinner(state)
            state = Map.put(state, :winner, w)
          else
            state = state
          end 
        else
          w = getWinner(state)
          state = Map.put(state, :winner, w)
        end
      end

      else
        state = state
      end
    else
      state = state
    end    
  end
end
