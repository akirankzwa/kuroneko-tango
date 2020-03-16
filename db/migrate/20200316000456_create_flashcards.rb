class CreateFlashcards < ActiveRecord::Migration[6.0]
  def change
    create_table :flashcards do |t|
      t.string :term
      t.text :definition
      t.integer :status

      t.timestamps
    end
  end
end
