require "spec_helper"

describe Property do
  it 'finds invalid phone number and improper length' do
    account = Account.create()
    property = Property.new
    property.account = account
    property.outbound_phone_numbers = ["123"]
    property.name = "test property"
    expect(property.valid?).to eq(false)
    expect(property.errors).to eq(
      {
        outbound_phone_numbers: ["is not valid", "needs to be 12 characters"]
      }
    )
  end

  it 'allows an empty phone number' do
    account = Account.create()
    property = Property.new
    property.account = account
    property.name = "test property"
    expect(property.valid?).to eq(true)
    expect(property.errors).to eq({})
  end

  it 'valids a correct phone number' do
    account = Account.create()
    property = Property.new
    property.account = account
    property.name = "test property"
    property.outbound_phone_numbers = ["+12398745678"]
    expect(property.valid?).to eq(true)
    expect(property.errors).to eq({})
  end

  it 'finds invalid number with a correct phone number' do
    account = Account.create()
    property = Property.new
    property.account = account
    property.name = "test property"
    property.outbound_phone_numbers = ["+12398745678", "12398745678+"]
    expect(property.valid?).to eq(false)
    expect(property.errors).to eq(
      outbound_phone_numbers: ["is not valid"]
    )
  end
end
