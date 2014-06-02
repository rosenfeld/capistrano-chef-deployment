require 'stringio'
require 'erb'
def template(filename)
  StringIO.new(ERB.new(File.open("config/templates/#{filename}").read).result binding)
end
