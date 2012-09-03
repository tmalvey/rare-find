class ListingParser

  def self.parse(raw_listing, query_id, transaction_id)
    parser = self.new
    listing = Listing.new

    link = raw_listing.xpath('a').first

    listing.query_id = query_id
    listing.transaction_id = transaction_id
    listing.url = link['href']
    listing.listing_id = listing.url[/[0-9]+/]
    listing.title = link.content
    listing.price = parser.element_content_by_id(raw_listing, '.itempp')
    listing.location = parser.element_content_by_id(raw_listing, '.itempn').gsub(/"^\(|\)$"/, '')
    listing.has_image = parser.element_content_by_id(raw_listing, '.itempx').empty? ? false : true
    listing.category = parser.element_content_by_id(raw_listing, '.itemcg').tr('<<', '')

    listing
  end

  def element_content_by_id(listing, id)
    elem = listing.css(id)
    elem.empty? ? '' : elem.first.content.strip
  end
end