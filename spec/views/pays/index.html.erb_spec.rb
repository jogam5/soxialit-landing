require 'spec_helper'

describe "pays/index" do
  before(:each) do
    assign(:pays, [
      stub_model(Pay,
        :plan_id => 1,
        :email => "Email"
      ),
      stub_model(Pay,
        :plan_id => 1,
        :email => "Email"
      )
    ])
  end

  it "renders a list of pays" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
  end
end
