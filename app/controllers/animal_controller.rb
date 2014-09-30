class AnimalController < ApplicationController

	skip_before_filter :verify_authenticity_token
	before_filter :cors_preflight_check
	after_filter :cors_set_access_control_headers

	def cors_set_access_control_headers
		# allow CORS (cross origin resource sharing)
		headers['Access-Control-Allow-Origin'] = '*'
		headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
		headers['Access-Control-Max-Age'] = "1728000"
		headers['Access-Control-Request-Method'] = '*'
		headers['Access-Control-Allow-Headers'] = 'Origin, Content-type, Accept, Authorization'
	end

	def cors_preflight_check
	    if request.method == :options
			headers['Access-Control-Allow-Origin'] = '*'
			headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
			headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, X-CSRF-Token'
			headers['Access-Control-Max-Age'] = '1728000'
			render :text => '', :content_type => 'text/plain'
	    end
	end

	def index
	
	end

	def adopt
		name = params[:name]
		animals = ["puppy", "kitten", "bunny"]
		pictures = { puppy: ["boo.jpg", "sleepycorgi.jpg", "pomeranianball.jpg"], 
			kitten: ["sleepykit.jpg", "upsidedownkit.jpg", "wolfkit.jpg"], 
			bunny: ["bunnyhatchling.jpg", "handfullofbun.jpg", "rollingbun.jpg"] 
		}
		domain = home_url
		path = "images/"
		pet = animals[rand(animals.length)]
		pet_picture = domain + path + pictures[pet.to_sym][rand(pictures[pet.to_sym].length)]
		pet_age = rand(11) + 1
		headers['Access-Control-Allow-Origin'] = '*'
		if params[:name]
			render json: {name: name, animal: pet, picture: pet_picture, age: pet_age}
		else 
			render json: {animal: pet, picture: pet_picture, age: pet_age}
		end
	end
end
