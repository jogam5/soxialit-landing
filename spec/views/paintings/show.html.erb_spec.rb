require 'spec_helper'

describe "paintings/show" do
  before(:each) do
    @painting = assign(:painting, stub_model(Painting,
      :image => "Image",
      :name => "Name",
      :product_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Image/)
    rendered.should match(/Name/)
    rendered.should match(/1/)
  end
end
