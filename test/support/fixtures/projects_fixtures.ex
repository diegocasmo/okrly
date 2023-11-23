defmodule Okrly.ProjectsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Okrly.Projects` context.
  """
  alias Okrly.Accounts

  @doc """
  Generate a project for the specified user
  """
  def project_fixture(%Accounts.User{} = user, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        name: "Severance Episode Insights",
        description:
          "In-depth exploration and review of each episode of the TV series Severance, focusing on thematic elements and character development.",
        start_date: Date.utc_today(),
        end_date: Date.add(Date.utc_today(), 180)
      })

    {:ok, project} = Okrly.Projects.create_project_for_user(user, attrs)

    project
  end
end
