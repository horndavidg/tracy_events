require 'rails_helper'

describe 'Event' do

  subject(:event) { Event.create(                        
  							description: "This is the event description",
                            name: "Taco Tuesday",
                            address: "2435 Lincoln Blvd. Tracy, CA, 95376",
                            start_time: "2311",
                            end_time: "0134",
                            creator_id: "31"
                            )}



    #These tests make sure User responds to: 
    it { is_expected.to respond_to :creator_id}
    it { is_expected.to respond_to :description}
    it { is_expected.to respond_to :name}
    it { is_expected.to respond_to :address}
    it { is_expected.to respond_to :start_time}
    it { is_expected.to respond_to :end_time}
 

end


