class CreateHosts < ActiveRecord::Migration[6.1]
  def change
    create_table :hosts do |t|
      t.string :hostname
      t.string :ip
      t.timestamp :first_seen
      t.timestamp :last_seen
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
