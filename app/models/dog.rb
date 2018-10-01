class Dog < ApplicationRecord
  has_many_attached :images
  belongs_to :user
  has_many :likes, dependent: :destroy

  # get likes for current dog (based on id)
  def get_likes
    Like.all.select {|like| like.dog_id == self.id}
  end

  # find likes only in past hour and then sort by, descending
  def self.last_hour
    Dog.all.each do |dog|
      count = dog.get_likes.select {|like| Time.now - like.created_at <= 1.hour}.count
      # update count so only includes likes in the past hour
      dog.update_attribute(:likes_past_hour, count)
    end
    # sort
    Dog.order(likes_past_hour: :desc)
  end
end
