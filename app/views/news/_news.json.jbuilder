json.extract! news, :id, :link_news, :link_img_news, :etiqueta, :subtitulo, :date_news, :created_at, :updated_at
json.url news_url(news, format: :json)
