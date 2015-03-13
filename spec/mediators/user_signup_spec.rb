require "spec_helper"

describe Mediators::UserSignup do
  it "creates a user from a provider" do
    Mediators::UserSignup.run({
      provider: 'github',
      uid: "12345"
    })
    user = User.first(provider: 'github', provider_id: "12345")
    expect(user.provider).to eq('github')
    expect(user.provider_id).to eq('12345')
    expect(user.status).to eq('pending')
  end
end
