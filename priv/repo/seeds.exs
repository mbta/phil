alias Phil.CharlieCards.CharlieCard
alias Phil.Products
alias Phil.Repo
alias Phil.Support.Factories.CharlieCardFactory

# Import all products with an upsert
Application.app_dir(:phil, "/priv/repo/seeds/products_import.csv")
|> Products.Importer.import()

# Delete all CharlieCards and insert 100
Repo.delete_all(CharlieCard)
CharlieCardFactory.insert_list(100, :charlie_card, batch_number: 1)
