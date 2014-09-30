# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  user       :string(255)
#  password   :string(255)
#  created_at :datetime
#  updated_at :datetime
#  count      :integer
#

class User < ActiveRecord::Base	

	# the success return code
    SUCCESS               =   1

    # cannot find the user/password pair in the database (for login only)
    ERR_BAD_CREDENTIALS   =  -1

    # trying to add a user that already exists (for add only)
    ERR_USER_EXISTS       =  -2

    # invalid user name (empty or longer than MAX_USERNAME_LENGTH) (for add)
    ERR_BAD_USERNAME      =  -3

    # invalid password name (longer than MAX_PASSWORD_LENGTH) (for add)
    ERR_BAD_PASSWORD      =  -4


    # maximum length of user name
    MAX_USERNAME_LENGTH = 128

    # maximum length of password
    MAX_PASSWORD_LENGTH = 128


	# validations
	validates :user, presence: true, uniqueness: true, length: { 
		maximum: MAX_USERNAME_LENGTH,
		too_long: "maximum of %{count} characters" 
	}
	validates :password, length: { 
		maximum: MAX_PASSWORD_LENGTH,
		too_long: "maximum of %{count} characters" 
	}

	# add new user with count = 1
	def self.add(user, password)
		current_user = new(user: user, password: password)
		if current_user.valid?
			current_user.count = 1
			current_user.save
			current_user.count
		else
			if user.empty? || user.length > 128
				ERR_BAD_USERNAME
			elsif exists?(user: user)
				ERR_USER_EXISTS
			elsif password.length > 128
				ERR_BAD_PASSWORD
			else
				false
			end
		end
	end

	# log in existing user and increase count by 1
	def self.login(user, password)
		current_user = find_by(user: user)
		if current_user.blank?
			ERR_BAD_CREDENTIALS
		elsif current_user.password != password
			ERR_BAD_CREDENTIALS
		else 
			current_user.count += 1
			current_user.save
			current_user.count
		end
	end

	def validate()
		
	end
end
