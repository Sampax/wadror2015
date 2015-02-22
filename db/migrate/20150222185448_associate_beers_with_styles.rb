class AssociateBeersWithStyles < ActiveRecord::Migration
  def change
    Beer.all.each do |beer|
      beer.style = get_style(beer.old_style)
      beer.save
    end

    remove_column :beers, :old_style
  end

  def get_style(name)
    style = Style.find_by name: name
    return style if style
    Style.create name: name, description: "not available"
  end
end
