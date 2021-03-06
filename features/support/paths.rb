module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in webrat_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the homepage/
      '/'

    when /the podcasts list/
      podcasts_path
    when /the landing page of podcast titled "([^\"]*)"/
      podcast_path(Podcast.find_by_title($1))
    when /the new podcast page/
      new_podcast_path
    when /edit page of podcast titled "([^\"]*)"/
      edit_podcast_path(Podcast.find_by_title($1))

    when /the auth page/
      auth_path

    # Add more mappings here.
    # Here is a more fancy example:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
