require 'rubygems'
require 'liquid'

file = "./template.liquid"
@template = Liquid::Template.parse(File.new(file_path).read) # Parses and compiles the template
test = @template.render('name' => 'tobi')
puts test