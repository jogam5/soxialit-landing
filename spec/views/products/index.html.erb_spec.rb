require 'spec_helper'

describe "products/index" do
  before(:each) do
    assign(:products, [
      stub_model(Product,
        :brand => "Brand",
        :description => "Description",
        :picture => "Picture",
        :title => "Title",
        :user_id => 1
      ),
      stub_model(Product,
        :brand => "Brand",
        :description => "Description",
        :picture => "Picture",
        :title => "Title",
        :user_id => 1
      )
    ])
  end

  it "renders a list of products" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Brand".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "Picture".to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
