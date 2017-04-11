class AddFk < ActiveRecord::Migration[5.0]
    def change
        add_foreign_key :images, :animals, column: :animal
        add_index :animals, [:name, :habitat, :food]
    end
end
