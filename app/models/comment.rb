class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  validates_presence_of :content, :user_id, :movie_id
  validates :user_id, :uniqueness => { :scope => :movie_id,
    :message => "Users may only write one review per movie." }
end
