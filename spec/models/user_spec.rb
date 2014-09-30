require 'spec_helper'

describe User do

  it "create valid account" do
    user = User.add("carina", "boo")

    expect(user).to eq(User::SUCCESS)
  end

  it "create account with empty user" do
    user = User.add("", "password")

    expect(user).to eq(-3)
  end

  it "create account with > 128 char user" do
    user = User.add("usernameijofwjoefjwifowjfowjiefojowejfoiwejiofjwoiafjwejfowajfwalfwaifjwlijefilwjfiawjijflwjffwefwefwefweafwefwefwafeawefawefafw9", "password")

    expect(user).to eq(User::ERR_BAD_USERNAME)
  end

  it "create account with repeat user" do
    user1 = User.add("username", "password1")
    user2 = User.add("username", "password2")

    expect(user1).to eq(User::SUCCESS)
    expect(user2).to eq(User::ERR_USER_EXISTS)
  end

  it "create account with > 128 password" do
    user = User.add("user", "passwordijofwjoefjwifowjfowjiefojowejfoiwejiofjwoiafjwejfowajfwalfwaifjwlijefilwjfiawjijflwjffwefwefwefweafwefwefwafeawefawefafw9")

    expect(user).to eq(User::ERR_BAD_PASSWORD)
  end

  it "create account with empty password" do
    user = User.add("user", "")

    expect(user).to eq(User::SUCCESS)
  end

  it "login with incorrect password" do
    User.add("user1", "password")
    user = User.login("user1", "passwordwrong")

    expect(user).to eq(User::ERR_BAD_CREDENTIALS)
  end

  it "login as nonexistant user" do
    user = User.login("nonexistant", "password")

    expect(user).to eq(User::ERR_BAD_CREDENTIALS)
  end

  it "login with correct user name and password" do
  	User.add("kevin", "isawseome")
    count = User.login("kevin", "isawseome")

    expect(count).to eq(2)
  end

  it "login twice with correct user name and password" do
  	User.add("kevincasey", "isawseome")
  	User.login("kevincasey", "isawseome")
    count = User.login("kevincasey", "isawseome")

    expect(count).to eq(3)
  end

end
