defmodule Cards do
  @moduledoc """
  Provides methods for creating and handling a deck of cards
  """

  @doc """
  Returns a list of string representing a deck of playing cards

  ## Example
      iex> Cards.create_deck |> Enum.take(3)
      ["Ace of Spades", "Two of Spades", "Three of Spades"]
  """
  def create_deck do
    values = [
      "Ace",
      "Two",
      "Three",
      "Four",
      "Five",
      "Six",
      "Seven",
      "Eight",
      "Nine",
      "Ten",
      "Jack",
      "Queen",
      "King"
    ]

    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    # for suit <- suits do
    #   for value <- values do
    #     "#{value} of #{suit}" # Nice try you goose, list of lists
    #   end
    # end

    # # Life is good...
    # cards = for suit <- suits do
    #   for value <- values do
    #     "#{value} of #{suit}"
    #   end
    # end

    # List.flatten(cards)

    # ... but it can be better!
    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
  Determines whether a deck contains a given card

  ## Examples
      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true
  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
  Divides a deck into a hand and the remainder of the deck. The `hand_size`
  indicated how many cards should be in the hand.

  ## Examples
      iex> deck = Cards.create_deck
      iex> {hand, _deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]
  """
  def deal(deck, hand_size) do
    # {*hand*, *remaining*}
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    # {status, binary} = File.read(filename)

    # The virgin conditional
    # if (status === :error)
    # ...

    # The chad pattern matching
    # case status do
    #   :ok -> :erlang.binary_to_term binary
    #   :error -> "That file does not exist"
    # end

    # The thad case pattern matching
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "That file does not exist"
    end
  end

  def create_hand(hand_size) do
    # This works...
    # deck = Cards.create_deck
    # deck = Cards.shuffle(deck)
    # hand = Cards.deal(deck, hand_size)

    # But this is the Elixir way
    # Note: Piping automatically puts the output as the first
    Cards.create_deck()
    # input to a function
    |> Cards.shuffle()
    |> Cards.deal(hand_size)

    # Note, it is important to design pipe functions to have consistent first
    # parameters
  end
end
