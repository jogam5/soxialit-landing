module GalleriesHelper
	def find_micropost_image(id)
		micropost = Micropost.find(id)
		if micropost.id > 450
			if !micropost.picture_url(:modal).nil?
				micropost.picture_url(:modal)
			else
				micropost.thumbnail
			end
		else
			micropost.thumbnail
		end
	end
end
