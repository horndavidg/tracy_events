require 'rails_helper'

describe 'Photo' do

  subject(:photo) { Photo.create(                        
  							creator_id: "25",
                            url: "http://www.visittampabay.com/image.aspx?id=670&width=1088&height=478&mar=1"
                            )}



    #These tests make sure User responds to: 
    it { is_expected.to respond_to :creator_id}
    it { is_expected.to respond_to :url}

    describe 'photo when it is invalid' do
    subject(:invalid_photo) { Photo.create(url:"", creator_id: "25")}

    it { is_expected.to_not be_valid}

  end
 

end

