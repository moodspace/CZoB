=begin
CZoB

CZoB API Specs

OpenAPI spec version: 1.0.0

Generated by: https://github.com/swagger-api/swagger-codegen.git

=end

class InitTables < ActiveRecord::Migration[5.0]
  def change
    create_table "animal".pluralize.to_sym, id: false do |t|
      t.bigint :id
      t.string :habitat
      t.string :food
      t.string :name
      t.string :detail

      t.timestamps

      t.primary_key :id
    end

    create_table "error".pluralize.to_sym, id: false do |t|
      t.integer :code
      t.string :message

      t.timestamps
    end

    create_table "image".pluralize.to_sym, id: false do |t|
      t.bigint :id
      t.string :filename
      t.bigint :animal

      t.timestamps

      t.primary_key :id
    end

    create_table "tag".pluralize.to_sym, id: false do |t|
      t.bigint :id
      t.integer :typ
      t.string :name

      t.timestamps

      t.primary_key :id
    end

  end
end
