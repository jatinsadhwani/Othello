defmodule Othello.AccountsTest do
  use Othello.DataCase

  alias Othello.Accounts

  describe "games" do
    alias Othello.Accounts.Game

    @valid_attrs %{gamename: "some gamename"}
    @update_attrs %{gamename: "some updated gamename"}
    @invalid_attrs %{gamename: nil}

    def game_fixture(attrs \\ %{}) do
      {:ok, game} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_game()

      game
    end

    test "list_games/0 returns all games" do
      game = game_fixture()
      assert Accounts.list_games() == [game]
    end

    test "get_game!/1 returns the game with given id" do
      game = game_fixture()
      assert Accounts.get_game!(game.id) == game
    end

    test "create_game/1 with valid data creates a game" do
      assert {:ok, %Game{} = game} = Accounts.create_game(@valid_attrs)
      assert game.gamename == "some gamename"
    end

    test "create_game/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_game(@invalid_attrs)
    end

    test "update_game/2 with valid data updates the game" do
      game = game_fixture()
      assert {:ok, game} = Accounts.update_game(game, @update_attrs)
      assert %Game{} = game
      assert game.gamename == "some updated gamename"
    end

    test "update_game/2 with invalid data returns error changeset" do
      game = game_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_game(game, @invalid_attrs)
      assert game == Accounts.get_game!(game.id)
    end

    test "delete_game/1 deletes the game" do
      game = game_fixture()
      assert {:ok, %Game{}} = Accounts.delete_game(game)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_game!(game.id) end
    end

    test "change_game/1 returns a game changeset" do
      game = game_fixture()
      assert %Ecto.Changeset{} = Accounts.change_game(game)
    end
  end
end
