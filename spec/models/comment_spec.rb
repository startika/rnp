require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Comment do

  it { should belong_to(:podcast) }

  it { should validate_presence_of(:podcast_id) }
  it { should validate_presence_of(:author_name) }
  it { should validate_presence_of(:body) }

end
