require "rails_helper"

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.new
  end

  describe "Validations" do
    context "with name, email, matching password and password_confirmation" do
      it "raises no error and saves the correct data" do
        @user.name = "User Alpha"
        @user.email = "user_alpha@email.com"
        @user.password = "password0"
        @user.password_confirmation = "password0"
        expect { @user.save! }.not_to raise_error

        expect(@user.id).to be_present
        expect(@user.created_at).to be_present
        expect(@user.updated_at).to be_present
        expect(@user.name).to include("User Alpha")
        expect(@user.email).to include("user_alpha@email.com")
        expect(@user.password_digest).to be_present
      end
    end

    context "with name, email, mismatching password and password_confirmation" do
      it "raises an error concerning mismatching password and password_confirmation" do
        @user.name = "User Alpha"
        @user.email = "user_alpha@email.com"
        @user.password = "password0"
        @user.password_confirmation = "password1"
        expect { @user.save! }.to raise_error(/Password confirmation doesn't match Password/)
      end
    end

    context "with name, matching password and password_confirmation but email already in use" do
      it "raises an error concerning email already in use" do
        @user.name = "User Alpha"
        @user.email = "user_alpha@email.com"
        @user.password = "password0"
        @user.password_confirmation = "password0"
        expect { @user.save! }.not_to raise_error

        @clone_user = User.new
        @clone_user.name = "User Alpha Clone"
        @clone_user.email = "user_alpha@email.com"
        @clone_user.password = "password1"
        @clone_user.password_confirmation = "password1"
        expect { @clone_user.save! }.to raise_error
      end
    end

    # test password at min length (6 chars)
    # test password at min-1 length (5 chars)
  end

  # describe ".authenticate_with_credentials" do
  #   # examples for this class method here
  #   # test email and correct password
  #   # test email with incorrect password
  #   # test email with whitespace before and correct password
  #   # test email with whitespace after and correct password
  #   # test email with whitespace before and after and correct password
  #   # test email with different casing and correct password
  # end
end
