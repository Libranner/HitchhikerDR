require "spec_helper"

describe UserMailer do
  describe "sign_up_confirmation" do
    let(:user){FactoryGirl.build(:user, :email => 'libranner@gmail.com')}
    let(:mail) { UserMailer.sign_up_confirmation(user) }

    it "renders the headers" do
      mail.subject.should eq('Welcome aboard!')
      mail.to.should eq(%w(libranner@gmail.com))
      mail.from.should eq(%w(hitchhikerdr@gmail.com))
    end


  end

end
