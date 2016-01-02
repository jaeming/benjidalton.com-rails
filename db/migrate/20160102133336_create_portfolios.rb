class CreatePortfolios < ActiveRecord::Migration
  def change
    create_table :portfolios do |t|
      t.string :title
      t.text :description
      t.string :image
      t.string :link_to_src
      t.string :link_to_site

      t.timestamps null: false
    end
  end
end
