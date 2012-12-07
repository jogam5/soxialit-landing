require 'spec_helper'

describe "sizes/show" do
  before(:each) do
    @size = assign(:size, stub_model(Size,
      :name => "Name",
      :product_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/1/)
  end
end
