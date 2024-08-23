require "spec_helper"
require "signup"

describe Signup do
  let(:email) { "user@example.com" }
  let(:account_name) { "Example" }

  let(:signup) { Signup.new(email: email, account_name: account_name) }

  let(:account) { double("account") }
  let(:user) { double("user") }

  describe "#save" do
    it "creates an account with one user" do
      expect(Account).to(
        receive(:create!)
          .with(name: account_name)
          .and_return(account)
      )
      expect(User).to(
        receive(:create!)
          .with(account: account, email: email)
          .and_return(user)
      )

      expect(signup.save).to be(true)
    end
  end

  describe "#user" do
    it "returns the user created by #save" do
      allow(Account).to(
        receive(:create!)
          .with(name: account_name)
          .and_return(account)
      )
      allow(User).to(
        receive(:create!)
          .with(account: account, email: email)
          .and_return(user)
      )

      signup.save

      expect(signup.user).to eq(user)
    end
  end
end
