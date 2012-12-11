require 'spec_helper'

describe StaticPagesController do

  describe "GET 'faq'" do
    it "returns http success" do
      get 'faq'
      response.should be_success
    end
  end

  describe "GET 'privacy'" do
    it "returns http success" do
      get 'privacy'
      response.should be_success
    end
  end

  describe "GET 'term'" do
    it "returns http success" do
      get 'term'
      response.should be_success
    end
  end

end
