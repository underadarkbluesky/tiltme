class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string     :title, default: '', null: false
      t.text       :description
      t.attachment :attachment
      t.text       :attachment_meta
      t.timestamps
    end
  end
end
