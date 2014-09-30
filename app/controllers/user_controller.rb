class UserController < ApplicationController

  def index
  
  end

  def add
    user = params[:user]
    password = params[:password]
    num = User.add(user, password)
    if num < 0
      render json: {errCode: num}
    else 
      render json: {errCode: User::SUCCESS, count: num}
    end
  end

  def login
    user = params[:user]
    password = params[:password]
    num = User.login(user, password)
    if num < 0
      render json: {errCode: num}
    else
      render json: {errCode: User::SUCCESS, count: num}
    end
  end

  def reset_fixture
    User.destroy_all
    render json: {errCode: 1}
  end

  def unit_tests
    output = `rspec #{Rails.root}/spec/`
    example = /(\d+) example/.match(output)[1]
    failures = /(\d+) failures/.match(output)[1]
    render json: {nrFailed: failures.to_i, output: output, totalTests: example.to_i}
  end

end
