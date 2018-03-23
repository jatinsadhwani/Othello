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
     game = Game.playing(socket.assigns[:game], tile, id)
     Othello.GameBackup.save(socket.assigns[:name], game)
     socket = assign(socket, :game, game)
     broadcast socket, "PlayerMadeAMove", game
     {:reply, {:ok, %{ "game" => Game.client_view(game)}}, socket}
  end

  def handle_in("restart", %{}, socket) do
     game = Game.restart()
     Othello.GameBackup.save(socket.assigns[:name], game)
     socket = assign(socket, :game, game)
     {:reply, {:ok, %{ "game" => Game.client_view(game)}}, socket}
  end

  def handle_in("flipback", %{}, socket) do
     game = Game.flipback(socket.assigns[:game])
     Othello.GameBackup.save(socket.assigns[:name], game)
     socket = assign(socket, :game, game)
     {:reply, {:ok, %{ "game" => Game.client_view(game)}}, socket}
  end

  def handle_in("playerupdate", %{"playername" => playername, "player_count" => player_count}, socket) do
     game = Game.playerupdate(socket.assigns[:game],playername,player_count)
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

