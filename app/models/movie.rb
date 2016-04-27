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

	def self.search(params)

		min_runtime = params[:runtime_in_minutes] ? params[:runtime_in_minutes].split("-")[0] : 0
		max_runtime = if params[:runtime_in_minutes] && params[:runtime_in_minutes].split("-")[1]
										params[:runtime_in_minutes].split("-")[1]
									else 
										maximum("runtime_in_minutes")
									end
		where(
			"title LIKE ?", "%#{params[:title]}%"
		).where(
			"director LIKE ?", "%#{params[:director]}%"
		).where(
			"runtime_in_minutes > :min AND runtime_in_minutes <= :max", {min: min_runtime, max: max_runtime}
		)
	end

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
