# this plugin is used to get the username of the PC from which the compilation process is initiated.
# the username is displayed on the debug page
module GetUsername
  def username(input)
    ENV['USER'] || ENV['USERNAME']
  end
end

Liquid::Template.register_filter(GetUsername)