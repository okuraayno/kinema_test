class MoviesController < ApplicationController
  def index
    if params[:looking_for]
      movie_title = params[:looking_for]
      url = "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['TMDB_API_KEY']}&language=ja&query=" + URI.encode_www_form_component(movie_title)
    else
      url = "https://api.themoviedb.org/3/movie/popular?api_key=#{ENV['TMDB_API_KEY']}&language=ja"
    end
    # 準備したURLをURIとして準備
    @url_params = URI.parse(url)
    # 実際にアクセスしてデータを取得
    @api_datas  = Net::HTTP.get(@url_params)
    # JSONデータを連想配列で取得
    @movies_infos     = JSON.parse(@api_datas)
    # JSONデータのresults配列内を参照
    @movies_datas = @movies_infos['results']
  end


  def show
    movie_id = params[:id]
    url = "https://api.themoviedb.org/3/movie/#{movie_id}?api_key=#{ENV['TMDB_API']}&language=ja"
    @movie = JSON.parse(Net::HTTP.get(URI.parse(url)))
  end
end


