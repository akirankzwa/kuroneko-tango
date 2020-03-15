class CreateSpeeches < ActiveRecord::Migration[6.0]
  def change
    create_table :speeches do |t|
      t.string :term
      t.text :definition
      t.integer :status

      t.timestamps
    end
  end
end
