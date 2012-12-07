require 'spec_helper'

describe "sizes/index" do
  before(:each) do
    assign(:sizes, [
      stub_model(Size,
        :name => "Name",
        :product_id => 1
      ),
      stub_model(Size,
        :name => "Name",
        :product_id => 1
      )
    ])
  end

  it "renders a list of sizes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
