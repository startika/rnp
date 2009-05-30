Given /^I have podcast titled "([^\"]*)"$/ do |title|
  Factory(:podcast, :title => title)
end

Given /^I have no podcasts$/ do
  Podcast.delete_all
end

Then /^I should see nice podcasts list null screen$/ do
  response.should have_tag('.null_content')
end
