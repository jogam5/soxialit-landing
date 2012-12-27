require 'spec_helper'

describe "partners/show" do
  before(:each) do
    @partner = assign(:partner, stub_model(Partner,
      :user_id => 1,
      :name => "Name",
      :email => "Email",
      :phone => "",
      :category => "Category",
      :brand => "Brand",
      :website => "Website",
      :city => "City",
      :address => "Address",
      :zipcode => "Zipcode"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Name/)
    rendered.should match(/Email/)
    rendered.should match(//)
    rendered.should match(/Category/)
    rendered.should match(/Brand/)
    rendered.should match(/Website/)
    rendered.should match(/City/)
    rendered.should match(/Address/)
    rendered.should match(/Zipcode/)
  end
end
