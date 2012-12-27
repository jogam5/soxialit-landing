require 'spec_helper'

describe "pays/show" do
  before(:each) do
    @pay = assign(:pay, stub_model(Pay,
      :plan_id => 1,
      :email => "Email"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Email/)
  end
end
