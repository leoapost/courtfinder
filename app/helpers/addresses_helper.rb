module AddressesHelper
  def format_address(addr)
    add = "<p property='address' typeof='http://schema.org/PostalAddress'>"
    add << "<span property='streetAddress'>#{addr.address_lines('<br />')}</span><br/>"
    if addr.town
      add << "<span property='addressLocality'>#{addr.town.name}</span><br/>" if addr.town.name.present?
      add << "<span property='addressRegion'>#{addr.town.county.name}</span><br/>" if (addr.town.county.present? && addr.town.county.name.present?)
    end
    add << "<span property='postalCode'>#{addr.postcode}</span></p>" if addr.postcode.present?

    add.html_safe
  end
end
