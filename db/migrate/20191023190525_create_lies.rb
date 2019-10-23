class CreateLies < ActiveRecord::Migration[5.2]
  def change
    create_table :lies do |t|
      t.text :text
      t.string :model_version
      t.integer :model_order
      t.string :state

      t.timestamps
    end
  end
end
