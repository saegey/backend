Sequel.migration do
  change do
    create_table(:property_units) do
      uuid         :uuid, default: Sequel.function(:uuid_generate_v4), primary_key: true
      uuid         :property_id, null: false
      uuid         :account_id, null: false
      timestamptz  :created_at, default: Sequel.function(:now), null: false
      timestamptz  :updated_at
    end
  end
end
