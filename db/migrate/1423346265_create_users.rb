Sequel.migration do
  change do
    create_table(:users) do
      primary_key  :id
      String       :first_name
      String       :last_name
      String       :email
      String       :provider
      String       :provider_id
      String       :crypted_password
      Integer      :account_id
      timestamptz  :created_at, default: Sequel.function(:now), null: false
      timestamptz  :updated_at
    end
  end
end
