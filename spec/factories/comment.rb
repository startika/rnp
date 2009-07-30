Factory.define :comment do |c|
  c.author_name "Listener"
  c.body "Small review."
  c.association :podcast
end
