namespace :african_poetics do

  desc "attempts to parse citation field into separate work fields"
  task citation: :environment do

    Work.where.not(citation: nil).each do |work|
      if work.citation.include?("http")
        words = work.citation.split(" ")
        # not looking to alter the citation field, just to
        # copy url into the source_link field
        url = words.select { |w| w =~ URI::regexp }
        work.source_link = url.first if url
        puts "Updating work #{work.id} with url from citation"
        work.save
      end
    end

  end

end
