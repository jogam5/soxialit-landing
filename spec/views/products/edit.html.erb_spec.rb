require 'spec_helper'

describe "products/edit" do
  before(:each) do
    @product = assign(:product, stub_model(Product,
      :brand => "MyString",
      :description => "MyString",
      :picture => "MyString",
      :title => "MyString",
      :user_id => 1
    ))
  end

  it "renders the edit product form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => products_path(@product), :method => "post" do
      assert_select "input#product_brand", :name => "product[brand]"
      assert_select "input#product_description", :name => "product[description]"
      assert_select "input#product_picture", :name => "product[picture]"
      assert_select "input#product_title", :name => "product[title]"
      assert_select "input#product_user_id", :name => "product[user_id]"
    end
  end
end
