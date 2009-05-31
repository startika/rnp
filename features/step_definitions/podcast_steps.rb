Given /^I have podcast titled "([^\"]*)"$/ do |title|
  Factory(:podcast, :title => title)
end

Given /^I have no podcasts$/ do
  Podcast.delete_all
end

Given /^I have exactly one podcast titled "([^\"]*)"$/ do |title|
  Podcast.destroy_all ["title LIKE ?", "%#{title}%"]
  Factory(:podcast, :title => title)
end

When /^I click "([^\"]*)" link of podcast titled "([^\"]*)"$/ do |link, title|
  podcast = Podcast.find :first, :conditions => { :title => title }
  click_link_within ".podcast .title:contains(\"#{title}\") ~ .controls", link
end

Then /^I should see nice podcasts list null screen$/ do
  response.should have_tag('.null_content')
end

Then /^I should see no podcasts titled "([^\"]*)"$/ do |title|
  response.should_not have_tag(".podcast .title", title)
end
