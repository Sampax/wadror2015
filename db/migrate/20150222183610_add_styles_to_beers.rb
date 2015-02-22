class AddStylesToBeers < ActiveRecord::Migration
  def up
    rename_column :beers, :style, :old_style
    add_column :beers, :style_id, :integer
  end
end
