class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.datetime :time
      t.string :url
      t.references :place, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
