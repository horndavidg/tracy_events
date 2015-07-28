require 'rails_helper'

describe 'User' do

  subject(:user) { User.create(
                            
  							email: "example@email.com",
                            name: "Frank",
                            google_id: "299499690607872387",
                            expires_at: 8983,
                            refresh_token: "98495890834598",
                            access_token: "29319328932893"
                            )}



    #These tests make sure User responds to: 
    it { is_expected.to respond_to :email}
    it { is_expected.to respond_to :name}
 

end
