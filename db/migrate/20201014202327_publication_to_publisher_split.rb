class PublicationToPublisherSplit < ActiveRecord::Migration[6.0]
  def change

    reversible do |direction|

      direction.up do
        # migrate date, then delete publications from works
        Publication.all.each do |publication|
          # if there are any news items, we should leave this record alone
          next if publication.news_items.count > 0

          # if this publication has any works, then it should actually
          # be a publisher instead!
          if publication.works.count > 0
            Publisher.create(
              name: publication.name,
              created_at: publication.created_at,
              location: publication.location,
              works: publication.works
            )
            publication.destroy
          end
        end
      end

      direction.down do
        # move all publishers into publications
        # there should not have been any repositories associated
        # with the original publications tied to works, but if there
        # were, they will be lost to time now
        Publisher.all.each do |publisher|
          Publication.create(
            name: publisher.name,
            created_at: publisher.created_at,
            location: publisher.location,
            works: publisher.works
          )
          publisher.destroy
        end
      end
    end

    remove_reference :works, :publication

  end
end
