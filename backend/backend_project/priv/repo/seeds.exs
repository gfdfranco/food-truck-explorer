# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     BackendProject.Repo.insert!(%BackendProject.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias BackendProject.Repo
alias BackendProject.FoodTrucks.Permit

csv_file_path = Application.get_env(:backend_project, :csv_file_path)

# Check if FoodTrucks is empty
if Repo.aggregate(Permit, :count, :id) == 0 do
  # Open the CSV file and read it
  csv_file_path
  |> File.stream!()
  |> CSV.decode!(headers: true)
  |> Enum.each(fn row ->
    latitude =
      case row["Latitude"] do
        "0" -> 0.0  # Treat "0" as a valid float 0.0
        "" -> nil
        nil -> nil
        value -> String.to_float(value)
      end

    longitude =
      case row["Longitude"] do
        "0" -> 0.0  # Treat "0" as a valid float 0.0
        "" -> nil
        nil -> nil
        value -> String.to_float(value)
      end

    Repo.insert!(%Permit{
      applicant: row["Applicant"],
      facility_type: row["FacilityType"],
      location_description: row["LocationDescription"],
      address: row["Address"],
      status: row["Status"],
      food_items: row["FoodItems"],
      latitude: latitude,
      longitude: longitude,
      location: row["Location"]
    })
  end)


  IO.puts("Inserted data from CSV into FoodTrucks.")
else
  IO.puts("FoodTrucks table already has data, skipping CSV import.")
end
