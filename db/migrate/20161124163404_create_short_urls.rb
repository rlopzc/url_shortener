class CreateShortUrls < ActiveRecord::Migration[5.0]
  def change
    create_table :short_urls do |t|
      t.string :original
      t.string :converted
      t.integer :count, default: 0

      t.timestamps
    end
  end
end
