class Movie < ActiveRecord::Base

	has_many :reviews

	validates :title, presence: true
	validates :director, presence: true
	validates :runtime_in_minutes, numericality: { only_integer: true }
	validates :description, presence: true
	validates :poster_image_url, presence: true
	validates :release_date, presence: true
	validate :release_date_is_in_the_past

	mount_uploader :poster_image_url, MoviePosterUploader

	scope :title_contains, ->(q) {where("title LIKE ?", "%" + q + "%")}
	scope :director_contains, ->(q) {where("director LIKE ?", "%" + q + "%")}
	scope :runtime_between, ->(min,max) {where("runtime_in_minutes > ? AND runtime_in_minutes <= ?", min, max)}

	def review_average
    reviews.size > 0 ? reviews.sum(:rating_out_of_ten)/reviews.size : 0
  end

	protected
		def release_date_is_in_the_past
			if release_date.present?
				errors.add(:release_date, "should be in the past") if release_date > Date.today
			end
		end

end
