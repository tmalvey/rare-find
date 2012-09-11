require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = "#{APP_ROOT}/spec/vcr"
  c.hook_into :fakeweb
end