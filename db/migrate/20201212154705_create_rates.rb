class CreateRates < ActiveRecord::Migration[6.1]
  def change
    create_table :rates do |t|
      t.string :base, limit: 3
      t.string :target, limit: 3
      t.decimal :value
      t.timestamp :created_at
    end
  end
end
