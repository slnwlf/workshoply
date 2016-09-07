module ReviewsHelper
	def update_rate_average(stars, dimension=nil, rateable_item)
    if rateable_item.average(dimension).nil?
      RatingCache.create! do |avg|
        avg.cacheable_id = self.id
        avg.cacheable_type = self.class.name
        avg.avg = stars
        avg.qty = 1
        avg.dimension = dimension
      end
    else
      a = rateable_item.average(dimension)
      a.qty = rateable_item.rates(dimension).count
      #If there is no rating for the model then delete the row from average rating. You might want to
      # update overall average also if using multiple dimension
      if a.qty == 0
        a.delete
      else
        a.avg = rateable_item.rates(dimension).average(:stars)
        a.save!(validate: false)
      end
    end
 	end

  def clear_rating (user, dimension, rateable_item)
    user_rating = user.ratings_given.where(dimension: dimension, rateable_id: rateable_item.id, rateable_type: rateable_item.class.name)
    Rate.delete(user_rating.first.id) unless user_rating.nil?
    update_rate_average(0, dimension, rateable_item)
  end
end
