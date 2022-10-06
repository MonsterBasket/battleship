class CreateDb < ActiveRecord::Migration[7.0]
  def change
    create_table :players do |t|
      t.string 'name'
    end
  end
end
