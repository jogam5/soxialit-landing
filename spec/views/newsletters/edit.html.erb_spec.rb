require 'spec_helper'

describe "newsletters/edit" do
  before(:each) do
    @newsletter = assign(:newsletter, stub_model(Newsletter,
      :title => "MyString",
      :description => "MyText",
      :imagen => "MyString"
    ))
  end

  it "renders the edit newsletter form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => newsletters_path(@newsletter), :method => "post" do
      assert_select "input#newsletter_title", :name => "newsletter[title]"
      assert_select "textarea#newsletter_description", :name => "newsletter[description]"
      assert_select "input#newsletter_imagen", :name => "newsletter[imagen]"
    end
  end
end
