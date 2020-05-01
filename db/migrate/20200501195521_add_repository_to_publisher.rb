class AddRepositoryToPublisher < ActiveRecord::Migration[6.0]
  def change
    add_reference :publishers, :repository, foreign_key: true
  end
end
