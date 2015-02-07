Sequel.migration do
  change do
    create_table(:properties) do
      uuid         :id, default: Sequel.function(:uuid_generate_v4), primary_key: true
      String       :name, null: false
      String       :phone_number
      timestamptz  :created_at, default: Sequel.function(:now), null: false
      timestamptz  :updated_at
      uuid         :account_id
    end
  end
end
