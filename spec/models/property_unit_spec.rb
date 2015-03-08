require "spec_helper"

describe PropertyUnit do
  it 'finds invalid phone number and improper length' do
    @property_unit = PropertyUnit.new
    @property_unit.phone_number = "123"
    expect(@property_unit.valid?).to eq(false)
    expect(@property_unit.errors).to eq(
      {
        phone_number: ["is not valid", "needs to be 12 characters"]
      }
    )
  end

  it 'finds invalid phone number' do
    @property_unit = PropertyUnit.new
    @property_unit.phone_number = "45678901+123"
    expect(@property_unit.valid?).to eq(false)
    expect(@property_unit.errors).to eq(
      {
        phone_number: ["is not valid"]
      }
    )
  end

  it 'validates phone_number is correct' do
    @property_unit = PropertyUnit.new
    @property_unit.phone_number = "+12345678123"
    expect(@property_unit.valid?).to eq(true)
    expect(@property_unit.errors).to eq({})
  end
end
