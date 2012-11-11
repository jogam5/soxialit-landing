require 'spec_helper'

describe "feedbacks/edit" do
  before(:each) do
    @feedback = assign(:feedback, stub_model(Feedback,
      :content => "MyText",
      :user_id => 1
    ))
  end

  it "renders the edit feedback form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => feedbacks_path(@feedback), :method => "post" do
      assert_select "textarea#feedback_content", :name => "feedback[content]"
      assert_select "input#feedback_user_id", :name => "feedback[user_id]"
    end
  end
end
