require 'spec_helper'

describe "sizes/edit" do
  before(:each) do
    @size = assign(:size, stub_model(Size,
      :name => "MyString",
      :product_id => 1
    ))
  end

  it "renders the edit size form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => sizes_path(@size), :method => "post" do
      assert_select "input#size_name", :name => "size[name]"
      assert_select "input#size_product_id", :name => "size[product_id]"
    end
  end
end
