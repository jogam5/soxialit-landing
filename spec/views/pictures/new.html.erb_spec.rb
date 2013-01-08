require 'spec_helper'

describe "pictures/new" do
  before(:each) do
    assign(:picture, stub_model(Picture,
      :project_id => 1,
      :image => "MyString"
    ).as_new_record)
  end

  it "renders new picture form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => pictures_path, :method => "post" do
      assert_select "input#picture_project_id", :name => "picture[project_id]"
      assert_select "input#picture_image", :name => "picture[image]"
    end
  end
end
