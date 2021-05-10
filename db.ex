defmodule Db do
  @moduledoc """
  Write a module Db that creates a database and is able to store, retrieve and delete elements in it.
  The function Db.destroy(db) will delete the database. We are including the destroy function so as to make the interface consistent.
  Where possible, use the List library modules to implement this exercise.
  What is critically important in this exercise, alongside learning how to use library modules, is following the interface provided.
  """

  @typedoc """
  Reference to a database
  """
  @type key :: atom()
  @type value :: any()
  @type dbref :: list()

  @doc """
  Returns a new, empty database
  """
  @spec new() :: dbref()
  def new do
    []
  end

  @doc """
  Destroys a database. In our case it is enough to no longer store the reference
  """
  @spec destroy(dbref()) :: :ok
  def destroy(_dbref) do
    :ok
  end

  @doc """
  Writes the value under the given key in the database
  """
  @spec write(dbref(), key(), value()) :: dbref()
  def write(dbref, key, value) do
    case List.keyfind(dbref, key, 0) do
      {^key, _value} ->
        List.keyreplace(dbref, key, 0, {key, value})
      _ ->
        [{key, value} | dbref]
    end
  end

  @doc """
  Deletes the value associated with the given key
  """
  @spec delete(dbref(), key()) :: dbref()
  def delete(dbref, key) do
    List.keydelete(dbref, key, 0)
  end

  @doc """
  Reads the value from the given key
  """
  @spec read(dbref(), key()) :: {:ok, value()} | {:error, :no_key}
  def read(dbref, key) do
    case List.keyfind(dbref, key, 0) do
      {_key, value} ->
        {:ok, value}
      nil ->
        {:error, :no_key}
    end
  end

  @doc """
  Matches all keys associated with the given value
  """
  @spec match(dbref(), value()) :: list(key())
  def match(dbref, value) do
    dbref
    |> Enum.filter(fn {_, v} -> v == value end)
    |> Enum.map(fn {key, _value} -> key end)
  end
end
