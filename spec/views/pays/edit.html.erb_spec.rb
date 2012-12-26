require 'spec_helper'

describe "pays/edit" do
  before(:each) do
    @pay = assign(:pay, stub_model(Pay,
      :plan_id => 1,
      :email => "MyString"
    ))
  end

  it "renders the edit pay form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => pays_path(@pay), :method => "post" do
      assert_select "input#pay_plan_id", :name => "pay[plan_id]"
      assert_select "input#pay_email", :name => "pay[email]"
    end
  end
end
