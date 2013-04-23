require 'spec_helper'

describe "items/new" do
  before(:each) do
    assign(:item, stub_model(Item,
      :description => "MyString",
      :gallery_id => 1,
      :gallery_token => "MyString",
      :micropost_id => 1
    ).as_new_record)
  end

  it "renders new item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => items_path, :method => "post" do
      assert_select "input#item_description", :name => "item[description]"
      assert_select "input#item_gallery_id", :name => "item[gallery_id]"
      assert_select "input#item_gallery_token", :name => "item[gallery_token]"
      assert_select "input#item_micropost_id", :name => "item[micropost_id]"
    end
  end
end
