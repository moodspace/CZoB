# CZoB
#
# CZoB API Specs
#
# OpenAPI spec version: 1.0.0
#
# Generated by: https://github.com/swagger-api/swagger-codegen.git
#
class AnimalsController < ApplicationController
  def index
    habitat = params[:habitat]
    food = params[:food]
    ret = []

    relation = {}
    if food
      relation['food'] = food
    end
    if habitat
      relation['habitat'] = habitat
    end

    Animal.where(relation).find_each do |a|
      images = []
      Image.where(animal: a.id).each do |img|
        images << { id: img.id, filename: img.filename }
      end
      ret << {
        id: a.id,
        habitat: a.habitat,
        food: a.food,
        name: a.name,
        detail: a.detail,
        images: images
      }
    end
    render json: ret
  end

  def destroy
    Animal.find(params[:id]).destroy
    render json: 'DELETED'.to_json
  end

  def show
    a = Animal.find(params[:id])
    images = []
    Image.where(animal: a.id).each do |img|
      images << { id: img.id, filename: img.filename }
    end
    render json: {
      id: a.id,
      habitat: a.habitat,
      food: a.food,
      name: a.name,
      detail: a.detail,
      images: images
    }
  end

  def create
    a = Animal.new
    a.habitat = params[:habitat]
    a.food = params[:food]
    a.name = params[:name]
    a.detail = params[:detail]

    t1_result = false
    if !Tag.exists?({typ: 0, name: a.habitat})
      t1 = Tag.new
      t1.typ = 0
      t1.name = a.habitat
      t1_result = t1.save
    else
      t1_result = true
    end

    t2_result = false
    if !Tag.exists?({typ: 1, name: a.habitat})
      t2 = Tag.new
      t2.typ = 1
      t2.name = a.food
      t2.save
      t2_result = t2.save
    else
      t2_result = true
    end

    if a.save && t1_result && t2_result
      render json: a.id.to_json
    else
      render json: {error: 'bad request', code: 400, message: 'unable to create record'}, status: 400
    end
  end

  def animals_put

    render json: { 'message' => 'yes, it worked' }
  end
end
