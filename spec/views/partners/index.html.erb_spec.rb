require 'spec_helper'

describe "partners/index" do
  before(:each) do
    assign(:partners, [
      stub_model(Partner,
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
      ),
      stub_model(Partner,
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
      )
    ])
  end

  it "renders a list of partners" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Category".to_s, :count => 2
    assert_select "tr>td", :text => "Brand".to_s, :count => 2
    assert_select "tr>td", :text => "Website".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => "Zipcode".to_s, :count => 2
  end
end
