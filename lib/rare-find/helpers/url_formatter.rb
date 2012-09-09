module URLFormatter
  def format_url
    self.url = "http://#{self.url}" unless self.url[/^https?/]
  end
end