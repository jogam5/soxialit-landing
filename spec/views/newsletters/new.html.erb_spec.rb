require 'spec_helper'

describe "newsletters/new" do
  before(:each) do
    assign(:newsletter, stub_model(Newsletter,
      :title => "MyString",
      :description => "MyText",
      :imagen => "MyString"
    ).as_new_record)
  end

  it "renders new newsletter form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => newsletters_path, :method => "post" do
      assert_select "input#newsletter_title", :name => "newsletter[title]"
      assert_select "textarea#newsletter_description", :name => "newsletter[description]"
      assert_select "input#newsletter_imagen", :name => "newsletter[imagen]"
    end
  end
end
