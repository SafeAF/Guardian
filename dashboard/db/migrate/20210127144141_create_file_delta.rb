class CreateFileDelta < ActiveRecord::Migration[6.1]
  def change
    create_table :file_delta do |t|
      t.string :filename
      t.string :directory
      t.timestamp :event_time
      t.boolean :moved_from_flag
      t.boolean :create_flag
      t.boolean :delete_flag
      t.boolean :modify_flag
      t.references :host, null: false, foreign_key: true

      t.timestamps
    end
  end
end
