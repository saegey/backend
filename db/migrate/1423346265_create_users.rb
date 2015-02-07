Sequel.migration do
  change do
    create_table(:users) do
      uuid         :uuid, default: Sequel.function(:uuid_generate_v4), primary_key: true
      String       :first_name
      String       :last_name
      String       :email
      String       :provider
      String       :provider_id
      String       :crypted_password
      uuid         :account_id
      timestamptz  :created_at, default: Sequel.function(:now), null: false
      timestamptz  :updated_at
    end
  end
end
