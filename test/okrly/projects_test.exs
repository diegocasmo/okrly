defmodule Okrly.ProjectsTest do
  use Okrly.DataCase

  alias Okrly.Projects
  alias Okrly.Projects.Project

  describe "list_user_projects/1" do
    test "returns all user projects" do
      user = user_fixture()
      project_1 = project_fixture(user)
      project_2 = project_fixture(user)

      other_user = user_fixture()
      other_project_1 = project_fixture(other_user)
      other_project_2 = project_fixture(other_user)

      assert Projects.list_user_projects(user) == [project_1, project_2]
      assert Projects.list_user_projects(other_user) == [other_project_1, other_project_2]
    end
  end

  describe "create_project_for_user/2" do
    test "with valid data creates a project" do
      owner = user_fixture()
      valid_attrs = %{name: "Great Atlantis"}

      assert {:ok, %Project{} = project} = Projects.create_project_for_user(owner, valid_attrs)
      assert project.name == "Great Atlantis"
    end

    test "does not allow to create a project with an end_date prior to its start_date" do
      owner = user_fixture()

      invalid_attrs =
        %{
          name: "Jupiter",
          start_date: Date.utc_today(),
          end_date: Date.add(Date.utc_today(), -180)
        }

      assert {:error, %Ecto.Changeset{}} = Projects.create_project_for_user(owner, invalid_attrs)
    end

    test "invalid data returns error changeset" do
      owner = user_fixture()
      invalid_attrs = %{name: nil}

      assert {:error, %Ecto.Changeset{}} = Projects.create_project_for_user(owner, invalid_attrs)
    end
  end
end
