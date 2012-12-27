require 'spec_helper'

describe "partners/new" do
  before(:each) do
    assign(:partner, stub_model(Partner,
      :user_id => 1,
      :name => "MyString",
      :email => "MyString",
      :phone => "",
      :category => "MyString",
      :brand => "MyString",
      :website => "MyString",
      :city => "MyString",
      :address => "MyString",
      :zipcode => "MyString"
    ).as_new_record)
  end

  it "renders new partner form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => partners_path, :method => "post" do
      assert_select "input#partner_user_id", :name => "partner[user_id]"
      assert_select "input#partner_name", :name => "partner[name]"
      assert_select "input#partner_email", :name => "partner[email]"
      assert_select "input#partner_phone", :name => "partner[phone]"
      assert_select "input#partner_category", :name => "partner[category]"
      assert_select "input#partner_brand", :name => "partner[brand]"
      assert_select "input#partner_website", :name => "partner[website]"
      assert_select "input#partner_city", :name => "partner[city]"
      assert_select "input#partner_address", :name => "partner[address]"
      assert_select "input#partner_zipcode", :name => "partner[zipcode]"
    end
  end
end
