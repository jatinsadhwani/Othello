defmodule Othello.UtilitiesTest do
  use Othello.DataCase

  alias Othello.Utilities

  describe "players" do
    alias Othello.Utilities.Players

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def players_fixture(attrs \\ %{}) do
      {:ok, players} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Utilities.create_players()

      players
    end

    test "list_players/0 returns all players" do
      players = players_fixture()
      assert Utilities.list_players() == [players]
    end

    test "get_players!/1 returns the players with given id" do
      players = players_fixture()
      assert Utilities.get_players!(players.id) == players
    end

    test "create_players/1 with valid data creates a players" do
      assert {:ok, %Players{} = players} = Utilities.create_players(@valid_attrs)
    end

    test "create_players/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Utilities.create_players(@invalid_attrs)
    end

    test "update_players/2 with valid data updates the players" do
      players = players_fixture()
      assert {:ok, players} = Utilities.update_players(players, @update_attrs)
      assert %Players{} = players
    end

    test "update_players/2 with invalid data returns error changeset" do
      players = players_fixture()
      assert {:error, %Ecto.Changeset{}} = Utilities.update_players(players, @invalid_attrs)
      assert players == Utilities.get_players!(players.id)
    end

    test "delete_players/1 deletes the players" do
      players = players_fixture()
      assert {:ok, %Players{}} = Utilities.delete_players(players)
      assert_raise Ecto.NoResultsError, fn -> Utilities.get_players!(players.id) end
    end

    test "change_players/1 returns a players changeset" do
      players = players_fixture()
      assert %Ecto.Changeset{} = Utilities.change_players(players)
    end
  end

  describe "players" do
    alias Othello.Utilities.Players

    @valid_attrs %{playername: "some playername"}
    @update_attrs %{playername: "some updated playername"}
    @invalid_attrs %{playername: nil}

    def players_fixture(attrs \\ %{}) do
      {:ok, players} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Utilities.create_players()

      players
    end

    test "list_players/0 returns all players" do
      players = players_fixture()
      assert Utilities.list_players() == [players]
    end

    test "get_players!/1 returns the players with given id" do
      players = players_fixture()
      assert Utilities.get_players!(players.id) == players
    end

    test "create_players/1 with valid data creates a players" do
      assert {:ok, %Players{} = players} = Utilities.create_players(@valid_attrs)
      assert players.playername == "some playername"
    end

    test "create_players/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Utilities.create_players(@invalid_attrs)
    end

    test "update_players/2 with valid data updates the players" do
      players = players_fixture()
      assert {:ok, players} = Utilities.update_players(players, @update_attrs)
      assert %Players{} = players
      assert players.playername == "some updated playername"
    end

    test "update_players/2 with invalid data returns error changeset" do
      players = players_fixture()
      assert {:error, %Ecto.Changeset{}} = Utilities.update_players(players, @invalid_attrs)
      assert players == Utilities.get_players!(players.id)
    end

    test "delete_players/1 deletes the players" do
      players = players_fixture()
      assert {:ok, %Players{}} = Utilities.delete_players(players)
      assert_raise Ecto.NoResultsError, fn -> Utilities.get_players!(players.id) end
    end

    test "change_players/1 returns a players changeset" do
      players = players_fixture()
      assert %Ecto.Changeset{} = Utilities.change_players(players)
    end
  end
end
