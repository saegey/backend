Sequel.migration do
  change do
    create_table(:properties) do
      primary_key  :id
      String       :name, null: false
      timestamptz  :created_at, default: Sequel.function(:now), null: false
      timestamptz  :updated_at
      Integer      :account_id
      String       :outbound_phone_numbers
    end
  end
end
