require 'spec_helper'

describe "products/show" do
  before(:each) do
    @product = assign(:product, stub_model(Product,
      :brand => "Brand",
      :description => "Description",
      :picture => "Picture",
      :title => "Title",
      :user_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Brand/)
    rendered.should match(/Description/)
    rendered.should match(/Picture/)
    rendered.should match(/Title/)
    rendered.should match(/1/)
  end
end
