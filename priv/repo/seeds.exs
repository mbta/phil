alias Phil.CharlieCards.CharlieCard
alias Phil.Repo
alias Phil.Support.CharlieCardFactory

Repo.delete_all(CharlieCard)

CharlieCardFactory.insert_list(100, :charlie_card, batch_number: 1)
