class AddFk < ActiveRecord::Migration[5.0]
    def change
        add_foreign_key :images, :animals, column: :animal
        add_index :tags, [:name, :typ]
    end
end
