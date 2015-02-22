Sequel.migration do
  change do
    create_table(:accounts) do
      primary_key  :id
      timestamptz  :created_at, default: Sequel.function(:now), null: false
      timestamptz  :updated_at
      Integer         :user_id
      String       :status
    end
  end
end
