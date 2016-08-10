class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.belongs_to :player1, null: false
      t.belongs_to :player2, null: false
      t.belongs_to :player3
      t.belongs_to :player4
      t.integer :winner
      t.timestamps
    end
  end
end
