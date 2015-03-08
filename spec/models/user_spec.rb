require "spec_helper"

describe User do
  let(:user) { 
    User.new({
      first_name: "John",
      last_name: "Doe",
      email: "test@test.com"
    }) 
  }

  it 'has invalid email address' do
    user.email = "test@test"
    expect(user.valid?).to eq(false)
    expect(user.errors).to eq({email: ["is invalid"]})
  end

  it 'does not have unique email address' do
    User.create({email: "test@test.com"})
    expect(user.valid?).to eq(false)
    expect(user.errors).to eq(email: ["is already taken"])
  end

  it 'has a valid unique email address' do
    expect(user.valid?).to eq(true)
    expect(user.errors).to eq({})
  end

  it 'has pending status' do
    user.last_name = nil
    user.save
    expect(user.status).to eq('pending')
  end

  it 'has active status' do
    user.save
    expect(user.status).to eq('active')
  end

  it 'has an account id' do
    user.save
    expect(user.account_id).to be_a(Fixnum)
  end

  it 'has specified account id' do
    account = Account.create
    user = User.new
    user.account = account
    user.save
    expect(user.account_id).to eq(account.id)
  end
end
