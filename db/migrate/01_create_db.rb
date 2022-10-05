class CreateDb < ActiveRecord::Migration[7]
  def change
    create_table :players do |t|
      t.string 'name'
    end
  end
end
