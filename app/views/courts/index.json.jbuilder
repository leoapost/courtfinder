json.set! "@context" do 
  json.set! "@vocab", 'http://schema.org/'
  json.geo 'http://www.w3.org/2003/01/geo/wgs84_pos#'
end

json.courts do
  json.array! @courts.visible do |court|
    json.set! "@id", court_path(court)
    
    json.image court.image_file_url if court.image_file_url.present?
    json.name court.name if court.name?

    json.description court.info if court.info?
    
    json.set! "@type", [ "Courthouse" ]
    json.set! "geo:latitude", court.latitude if court.latitude?
    json.set! "geo:longitude", court.longitude if court.longitude?
    
    addresses = court.addresses
    if address = (addresses.postal.first || addresses.visiting.first)
      json.set! :address do
        json.set! "@type", 'PostalAddress'
        json.postalCode address.postcode if address.postcode?
        if address.town.present?
          json.town address.town.name if address.town.name?
          json.addressRegion address.town.county.name if (address.town.county.present? and address.town.county.name?)
        end
        street_address = []
        street_address.push address.address_line_1 if address.address_line_1?
        street_address.push address.address_line_2 if address.address_line_2?
        street_address.push address.address_line_3 if address.address_line_3?
        street_address.push address.address_line_4 if address.address_line_4?
        street_address.push address.dx if address.dx?
        json.streetAddress street_address.join(', ')
      end
    end
    
    telephone_contacts = court.contacts.inject([]) do | acc, contact |
      contact_line = contact.contact_type.name
      contact_line += " (" + contact.name + ")" if contact.name?
      contact_line += ": " + contact.telephone
      acc.push contact_line
    end
    json.telephone telephone_contacts if telephone_contacts.any?
    
    contact_points = court.emails.inject([]) do | acc, email |
      acc.push({:contactType => email.description, :email => email.address, :@type => "ContactPoint"})
    end
    
    json.contactPoint contact_points if contact_points.any?
  end
end