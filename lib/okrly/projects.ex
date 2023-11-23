defmodule Okrly.Projects do
  @moduledoc """
  The Projects context.
  """

  import Ecto.Query, warn: false
  alias Okrly.Accounts
  alias Okrly.Repo

  alias Okrly.Projects.Project

  @doc """
  Returns the list of projects of the specified user
  """
  def list_user_projects(%Accounts.User{id: user_id}) do
    Repo.all(from p in Project, where: p.user_id == ^user_id, order_by: [desc: p.inserted_at])
  end

  @doc """
  Creates a project for the specified user
  """
  def create_project_for_user(%Accounts.User{} = user, attrs \\ %{}) do
    user
    |> Ecto.build_assoc(:projects, attrs)
    |> Project.changeset(attrs)
    |> Repo.insert()
  end
end
