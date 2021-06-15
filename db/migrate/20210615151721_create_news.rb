class CreateNews < ActiveRecord::Migration[6.1]
  def change
    create_table :news do |t|
      t.string :link_news
      t.string :link_img_news
      t.string :etiqueta
      t.string :subtitulo
      t.datetime :date_news

      t.timestamps
    end
  end
end
