Given /^podcast titled "([^\"]*)" has following comments:$/ do |podcast_title, comments_table|
  podcast = Podcast.find_by_title(podcast_title)

  # don't know is it good to invoke should matchers in Given step definitions
  podcast.should_not be_nil

  comments_table.hashes.each do |hash|
    Factory(:comment, :podcast => podcast, :author_name => hash['name'], :author_url => hash['url'], :body => hash['body'])
  end
end
