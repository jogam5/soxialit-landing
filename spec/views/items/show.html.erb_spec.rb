require 'spec_helper'

describe "items/show" do
  before(:each) do
    @item = assign(:item, stub_model(Item,
      :description => "Description",
      :gallery_id => 1,
      :gallery_token => "Gallery Token",
      :micropost_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Description/)
    rendered.should match(/1/)
    rendered.should match(/Gallery Token/)
    rendered.should match(/2/)
  end
end
