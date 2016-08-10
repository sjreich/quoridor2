class CreateMoves < ActiveRecord::Migration[5.0]
  def change
    create_table :moves do |t|
      t.belongs_to :game, foreign_key: true, dependent: :delete
      t.integer :ordinal
      t.integer :player
      t.integer :variety
      t.integer :x
      t.integer :y
      t.timestamps
    end
  end
end
