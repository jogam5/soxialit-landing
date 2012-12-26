require 'spec_helper'

describe PayController do

  describe "GET 'plan_id:integer'" do
    it "returns http success" do
      get 'plan_id:integer'
      response.should be_success
    end
  end

  describe "GET 'email:string'" do
    it "returns http success" do
      get 'email:string'
      response.should be_success
    end
  end

end
