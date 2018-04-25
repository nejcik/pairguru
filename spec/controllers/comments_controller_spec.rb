require "rails_helper"

describe CommentsController do
  it "is not valid add two comments to the same movie by one user" do 
    comment2 = build(:comment, id: 2, user_id: 1, movie_id: 1)
    expect(comment2).to_not be_valid
  end
end