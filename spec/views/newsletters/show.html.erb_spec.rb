require 'spec_helper'

describe "newsletters/show" do
  before(:each) do
    @newsletter = assign(:newsletter, stub_model(Newsletter,
      :title => "Title",
      :description => "MyText",
      :imagen => "Imagen"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/MyText/)
    rendered.should match(/Imagen/)
  end
end
