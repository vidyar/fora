module TopicSteps
  def topic
    @topic ||= attributes_for(:topic)
  end

  step 'there exists a bunch of topics' do
    create(:user) do |user|
      create_list(:topic, 21, user: user)
    end
  end

  step 'I click on one topic\'s title' do
    find('#topics div.topic-item:first-child div.span10 > a:first-child').click
  end

  step 'I should see the topic\'s content' do
    expect(page).to have_selector('#topic-detail .topic-content')
  end

  step 'I submit with the topic\'s title' do
    fill_in 'topic_title', with: topic[:title]
    fill_in 'topic_body',  with: topic[:body]
    click_button "Create Topic"
  end

  step "I should see the topic created" do
    expect(page).to have_selector('h3', text: topic[:title])
  end
end

RSpec.configure { |c| c.include TopicSteps }
