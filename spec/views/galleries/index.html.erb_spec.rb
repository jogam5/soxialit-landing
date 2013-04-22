require 'spec_helper'

describe "galleries/index" do
  before(:each) do
    assign(:galleries, [
      stub_model(Gallery,
        :name => "Name",
        :description => "Description",
        :token => "Token"
      ),
      stub_model(Gallery,
        :name => "Name",
        :description => "Description",
        :token => "Token"
      )
    ])
  end

  it "renders a list of galleries" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "Token".to_s, :count => 2
  end
end
