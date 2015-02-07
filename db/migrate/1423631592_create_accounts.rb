Sequel.migration do
  change do
    create_table(:accounts) do
      uuid         :uuid, default: Sequel.function(:uuid_generate_v4), primary_key: true
      timestamptz  :created_at, default: Sequel.function(:now), null: false
      timestamptz  :updated_at
      uuid         :user_id
      String       :status
    end
  end
end
