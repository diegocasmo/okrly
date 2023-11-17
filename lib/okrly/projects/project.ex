defmodule Okrly.Projects.Project do
  use Ecto.Schema
  import Ecto.Changeset

  schema "projects" do
    field :name, :string
    field :description, :string
    field :start_date, :date
    field :end_date, :date
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  def changeset(project, attrs) do
    project
    |> cast(attrs, [:name, :description, :start_date, :end_date, :user_id])
    |> validate_required([:name, :user_id])
    |> validate_date_range(:start_date, :end_date)
    |> assoc_constraint(:user)
  end

  defp validate_date_range(changeset, start_date_field, end_date_field) do
    start_date = get_field(changeset, start_date_field)
    end_date = get_field(changeset, end_date_field)

    case {start_date, end_date} do
      {nil, _} ->
        changeset

      {_, nil} ->
        changeset

      {start_date, end_date} ->
        case Date.compare(start_date, end_date) do
          :gt ->
            add_error(
              changeset,
              end_date_field,
              "must be greater than or equal to the start date"
            )

          _ ->
            changeset
        end
    end
  end
end
