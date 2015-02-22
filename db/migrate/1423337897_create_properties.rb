Sequel.migration do
  change do
    create_table(:properties) do
      primary_key  :id
      String       :name, null: false
      String       :phone_number
      timestamptz  :created_at, default: Sequel.function(:now), null: false
      timestamptz  :updated_at
      Integer      :account_id
    end
  end
end
