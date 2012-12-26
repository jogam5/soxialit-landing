require 'spec_helper'

describe "pays/new" do
  before(:each) do
    assign(:pay, stub_model(Pay,
      :plan_id => 1,
      :email => "MyString"
    ).as_new_record)
  end

  it "renders new pay form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => pays_path, :method => "post" do
      assert_select "input#pay_plan_id", :name => "pay[plan_id]"
      assert_select "input#pay_email", :name => "pay[email]"
    end
  end
end
