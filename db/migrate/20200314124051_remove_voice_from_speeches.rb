class RemoveVoiceFromSpeeches < ActiveRecord::Migration[6.0]
  def change

    remove_column :speeches, :voice, :string
  end
end
