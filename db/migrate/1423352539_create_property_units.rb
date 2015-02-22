Sequel.migration do
  change do
    create_table(:property_units) do
      primary_key  :id
      Integer      :property_id, null: false
      Integer      :account_id, null: false
      String       :pin_code
      timestamptz  :created_at, default: Sequel.function(:now), null: false
      timestamptz  :updated_at
    end
  end
end
