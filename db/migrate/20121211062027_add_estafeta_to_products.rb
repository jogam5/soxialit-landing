class AddEstafetaToProducts < ActiveRecord::Migration
  def change
    add_column :products, :tipo_envio, :string
    add_column :products, :peso, :int
    add_column :products, :alto, :int
    add_column :products, :largo, :int
    add_column :products, :ancho, :int
    add_column :products, :price_estafeta, :decimal
  end
end
