class MasterMigration < ActiveRecord::Migration[6.0]
  def change
    create_table :groups do |t|
      t.string :name

      t.timestamps
    end

    create_table :flashcards do |t|
      t.string :term
      t.text :definition
      t.integer :status
      t.references :group, foreign_key: true

      t.timestamps
    end
  end
end
