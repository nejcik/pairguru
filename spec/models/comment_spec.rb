require "rails_helper"

describe Comment do
  
  it "is not valid without user" do
    expect(Comment.new(content: 'Anything', movie_id: 2)).not_to be_valid
  end
  
  it "is not valid without movie" do
    expect(Comment.new(content: 'Anything', user_id: 2)).not_to be_valid
  end
end