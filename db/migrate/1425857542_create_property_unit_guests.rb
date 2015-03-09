Sequel.migration do
  change do
    create_table(:property_unit_guests) do
      primary_key  :id
      Integer      :property_unit_id, null: false
      Integer      :account_id, null: false
      String       :pin_code, null: false
      String       :email
      String       :phone_number
      timestamptz  :expires_at
      timestamptz  :created_at, default: Sequel.function(:now), null: false
      timestamptz  :updated_at
    end
  end
end
