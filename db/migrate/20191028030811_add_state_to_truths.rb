class AddStateToTruths < ActiveRecord::Migration[5.2]
  def change
    add_index :truths, :state
  end
end
