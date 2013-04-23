require 'spec_helper'

describe "items/index" do
  before(:each) do
    assign(:items, [
      stub_model(Item,
        :description => "Description",
        :gallery_id => 1,
        :gallery_token => "Gallery Token",
        :micropost_id => 2
      ),
      stub_model(Item,
        :description => "Description",
        :gallery_id => 1,
        :gallery_token => "Gallery Token",
        :micropost_id => 2
      )
    ])
  end

  it "renders a list of items" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Gallery Token".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
