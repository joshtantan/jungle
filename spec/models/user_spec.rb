require "rails_helper"

RSpec.describe User, type: :model do
  describe "Validations" do
    context "with name, email, matching password and password_confirmation" do
      it "raises no error and saves the correct data" do
        @user = User.new({
          name: "User Alpha",
          email: "user_alpha@email.com",
          password: "Password0",
          password_confirmation: "Password0",
        })

        expect(@user).to be_valid
      end
    end

    context "with name, email, mismatching password and password_confirmation" do
      it "raises an error concerning mismatching password and password_confirmation" do
        @user = User.new({
          name: "User Bravo",
          email: "user_bravo@email.com",
          password: "password0",
          password_confirmation: "password1",
        })

        expect { @user.save! }.to raise_error(/Password confirmation doesn't match Password/)
      end
    end

    context "with name, matching password and password_confirmation but email already in use" do
      it "raises an error concerning email already in use" do
        @user = User.create!({
          name: "User Charlie",
          email: "user_charlie@email.com",
          password: "password0",
          password_confirmation: "password0",
        })

        @duplicate_user = User.new({
          name: "User Charlie",
          email: "user_charlie@email.com",
          password: "password0",
          password_confirmation: "password0",
        })

        expect { @duplicate_user.save! }.to raise_error(/Email has already been taken/)
      end
    end

    context "with name, email, matching but under-limit (5 chars) password and password_confirmation" do
      it "raises an error concerning password under minimum length" do
        @user = User.new({
          name: "User Delta",
          email: "user_delta@email.com",
          password: "12345",
          password_confirmation: "12345",
        })

        expect { @user.save! }.to raise_error(/Password is too short/)
      end
    end

    context "with name, email, matching but over-limit (21 chars) password and password_confirmation" do
      it "raises an error concerning password over maximum length" do
        @user = User.new({
          name: "User Echo",
          email: "user_echo@email.com",
          password: "1234567890ABCEDEGHIJK",
          password_confirmation: "1234567890ABCEDEGHIJK",
        })

        expect { @user.save! }.to raise_error(/Password is too long/)
      end
    end
  end

  describe ".authenticate_with_credentials" do
    before do
      User.create!({
        name: "User Foxtrot",
        email: "user_foxtrot@email.com",
        password: "Password6",
        password_confirmation: "Password6",
      })
    end

    context "with email and correct password" do
      it "returns the correct user" do
        params = {
          email: "user_foxtrot@email.com",
          password: "Password6",
        }
        user = User.authenticate_with_credentials(params[:email], params[:password])

        expect(user).to_not be_nil
        expect(user.name).to include("User Foxtrot")
        expect(user.email).to include("user_foxtrot@email.com")
      end
    end

    context "with email and incorrect password" do
      it "returns nil" do
        params = {
          email: "user_foxtrot@email.com",
          password: "Password7",
        }
        user = User.authenticate_with_credentials(params[:email], params[:password])

        expect(user).to be_nil
      end
    end

    context "with unregistered email and password" do
      it "returns nil" do
        params = {
          email: "unregistered@email.com",
          password: "Unregistered0",
        }
        user = User.authenticate_with_credentials(params[:email], params[:password])

        expect(user).to be_nil
      end
    end

    context "with email with whitespace before and correct password" do
      it "returns the correct user" do
        params = {
          email: "  user_foxtrot@email.com",
          password: "Password6",
        }
        user = User.authenticate_with_credentials(params[:email], params[:password])

        expect(user).to_not be_nil
        expect(user.name).to include("User Foxtrot")
        expect(user.email).to include("user_foxtrot@email.com")
      end
    end

    context "with email with whitespace after and correct password" do
      it "returns the correct user" do
        params = {
          email: "user_foxtrot@email.com  ",
          password: "Password6",
        }
        user = User.authenticate_with_credentials(params[:email], params[:password])

        expect(user).to_not be_nil
        expect(user.name).to include("User Foxtrot")
        expect(user.email).to include("user_foxtrot@email.com")
      end
    end

    context "with email with whitespace before and after and correct password" do
      it "returns the correct user" do
        params = {
          email: "  user_foxtrot@email.com  ",
          password: "Password6",
        }
        user = User.authenticate_with_credentials(params[:email], params[:password])

        expect(user).to_not be_nil
        expect(user.name).to include("User Foxtrot")
        expect(user.email).to include("user_foxtrot@email.com")
      end
    end

    context "with email with incorrect casing and correct password" do
      it "returns the correct user" do
        params = {
          email: "  uSeR_foXtRot@Email.COM  ",
          password: "Password6",
        }
        user = User.authenticate_with_credentials(params[:email], params[:password])

        expect(user).to_not be_nil
        expect(user.name).to include("User Foxtrot")
        expect(user.email).to include("user_foxtrot@email.com")
      end
    end
  end
end
