require 'spec_helper'

describe "paintings/edit" do
  before(:each) do
    @painting = assign(:painting, stub_model(Painting,
      :image => "MyString",
      :name => "MyString",
      :product_id => 1
    ))
  end

  it "renders the edit painting form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => paintings_path(@painting), :method => "post" do
      assert_select "input#painting_image", :name => "painting[image]"
      assert_select "input#painting_name", :name => "painting[name]"
      assert_select "input#painting_product_id", :name => "painting[product_id]"
    end
  end
end
