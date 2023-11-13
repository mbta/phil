alias Phil.Partners.Partner
alias Phil.Repo

Repo.delete_all(Partner)

Enum.each(
  [
    "Acton",
    "Attleboro",
    "Arlington",
    "Boston",
    "Brockton",
    "Brookline",
    "Cambridge",
    "Chelsea",
    "Everett",
    "Framingham",
    "Lexington",
    "Malden",
    "Medford",
    "Melrose",
    "Newton",
    "North Shore",
    "Quincy",
    "Reading",
    "Revere",
    "Somerville",
    "Wakefield",
    "Watertown",
    "Winthrop",
    "Worcester"
  ],
  fn name ->
    Repo.insert!(%Partner{name: name, type: :municipality})
  end
)
