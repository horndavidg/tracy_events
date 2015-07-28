require 'rails_helper'

describe 'Comment' do

  subject(:comment) { Comment.create(                        
  							creator_id: "42",
                            content: "This is the content of my comment"
                            )}



    #These tests make sure User responds to: 
    it { is_expected.to respond_to :creator_id}
    it { is_expected.to respond_to :content}
 

end


