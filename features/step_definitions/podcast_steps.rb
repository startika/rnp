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

Given /^I have no podcasts titled "([^\"]*)"$/ do |title|
  Podcast.destroy_all ["title LIKE ?", "%#{title}%"]
end

Given /^I have a couple of podcasts$/ do
  5.times do |idx|
    Factory(:podcast, :title => "Podcast #{idx + 1}")
  end
end

When /^I click "([^\"]*)" link of podcast titled "([^\"]*)"$/ do |link, title|
  podcast = Podcast.find :first, :conditions => { :title => title }
  click_link_within ".podcast .title:contains(\"#{title}\") ~ .controls", link
end

When /^I'm creating podcast with title "([^\"]*)"$/ do |new_title|
  visit podcasts_path, :post, :podcast => Factory.attributes_for(:podcast, :title => new_title)
end

When /^I'm updating podcast titled "([^\"]*)" with title "([^\"]*)"$/ do |title, new_title|
  podcast = Podcast.find_by_title(title)
  visit podcast_path(podcast), :put,
    :id => podcast.id,
    :podcast => Factory.attributes_for(:podcast, :title => new_title)
end

When /^I'm deleting podcast titled "([^\"]*)"$/ do |title|
  podcast = Podcast.find_by_title(title)
  visit podcast_path(podcast), :delete, :id => podcast.id
end

When /^I click on the title of podcast titled "([^\"]*)"$/ do |title|
  click_link_within ".podcast .title:contains(\"#{title}\")", title
end

Then /^I should see nice podcasts list null screen$/ do
  response.should have_tag('.null_content')
end

Then /^I should see no podcasts titled "([^\"]*)"$/ do |title|
  response.should_not have_tag(".podcast .title", title)
end

Then /^I should see podcasts are numbered$/ do
  assigns['podcasts'].each do |p|
    response.should have_tag(".podcast") do
      with_tag(".number", /^[^\d]*#{p.number}$/)
      with_tag(".title", "#{p.title}")
    end
  end
end

Then /^I should see podcast controls$/ do
  response.should have_tag(".podcast .controls")
end

Then /^I should not see podcast controls$/ do
  response.should_not have_tag(".podcast .controls")
end
