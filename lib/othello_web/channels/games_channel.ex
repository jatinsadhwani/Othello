defmodule OthelloWeb.GamesChannel do
  use OthelloWeb, :channel

  alias Othello.Game

  def join("games:" <> name, payload, socket) do
    if authorized?(payload) do
      game = Othello.GameBackup.load(name) || Game.new()
      socket = socket
      |> assign(:game, game)
      |> assign(:name, name)
      {:ok, %{"join" => name, "game" => Game.client_view(game)}, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("tile", %{"tile" => tile, "id" => id}, socket) do
     game0 = Othello.GameBackup.load(socket.assigns[:name])
     game = Game.playing(game0, tile, id)
     Othello.GameBackup.save(socket.assigns[:name], game)
     socket = assign(socket, :game, game)
     broadcast socket, "PlayerMadeAMove", game
     {:reply, {:ok, %{ "game" => Game.client_view(game)}}, socket}
  end

  def handle_in("restart", %{"id" => id}, socket) do
     game0 = Othello.GameBackup.load(socket.assigns[:name])
     game = Game.restart(game0, id)
     Othello.GameBackup.save(socket.assigns[:name], game)
     socket = assign(socket, :game, game)
     broadcast socket, "QuitGame", game
     {:reply, {:ok, %{ "game" => Game.client_view(game)}}, socket}
  end

  def handle_in("quit", %{}, socket) do
     game0 = Othello.GameBackup.load(socket.assigns[:name])
     game = Game.quit(game0)
     Othello.GameBackup.delete(socket.assigns[:name])
     socket = assign(socket, :game, game)
     {:reply, {:ok, %{ "game" => Game.client_view(game)}}, socket}
  end

  def handle_in("playerupdate", %{"playername" => playername, "player_count" => player_count}, socket) do
     game0 = Othello.GameBackup.load(socket.assigns[:name]) || socket.assigns[:game]
     game = Game.playerupdate(game0,playername,player_count)
     Othello.GameBackup.save(socket.assigns[:name], game)
     socket = assign(socket, :game, game)
     broadcast socket, "PlayerJoined", game
     {:reply, {:ok, %{ "game" => Game.client_view(game)}}, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end

