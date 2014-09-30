class AnimalController < ApplicationController
	def index
	
	end

	def adopt
		animals = ["puppy", "kitten", "bunny"]
		pictures = { puppy: ["boo.jpg", "sleepycorgi.jpg", "pomeranianball.jpg"], 
			kitten: ["sleepykit.jpg", "upsidedownkit.jpg", "wolfkit.jpg"], 
			bunny: ["bunnyhatchling.jpg", "handfullofbun.jpg", "rollingbun.jpg"] 
		}
		domain = url_for(:only_path => false)
		path = "/images/"
		pet = animals[rand(animals.length)]
		pet_picture = domain + path + pictures[pet.to_sym][rand(pictures[pet.to_sym].length)]
		pet_age = rand(11) + 1
		render json: {animal: pet, picture: pet_picture, age: pet_age}
	end
end
