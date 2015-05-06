-module(sglobally_util).
-include("includes.hrl").

-export([newsdb_url/0,		 		  
		 video_count/3,
		 popular_videos/3,
		 more_videos_pagination/3,
		 more_videos/2,
		 more_data/1,
		 video_data/1,
		 more_news/3,
		 more_videos/3,
		 news_count/1,
		 videos_count/1,
		 news_item_url/1
		]).

newsdb_url() ->
	string:concat(?COUCHDB_URL, ?COUCHDB_TEXT_GRAPHICS)
.


news_item_url(Id) ->
	string:concat(?MODULE:newsdb_url(),Id)
.

more_data(Doc_id) ->
	string:concat(?MODULE:newsdb_url(), Doc_id)
.

more_news(Category, Limit, Skip) ->
	Url  = string:concat(?MODULE:newsdb_url(), "_design/cover_media/_view/"), 
	Url1 = string:concat(Url,Category ),	
	Url3 = string:concat(Url1, "?descending=true&limit="),
	Url4 = string:concat(Url3, Limit),
	Url5 = string:concat(Url4, "&skip="),
	string:concat(Url5, Skip).

more_videos(Category, Limit, Skip) ->
	Url  = string:concat(?MODULE:newsdb_url(), "_design/video_design/_view/"), 
	Url1 = string:concat(Url,Category ),	
	Url3 = string:concat(Url1, "?descending=true&limit="),
	Url4 = string:concat(Url3, Limit),
	Url5 = string:concat(Url4, "&skip="),
	string:concat(Url5, Skip).

news_count(Category) ->
	Url1 = string:concat(?MODULE:newsdb_url(), "_design/entertainment_design/_view/"),
	Url2 = string:concat(Url1, Category),	
	string:concat(Url2, "?descending=true&limit=1")
.

videos_count(Category) ->
	Url1 = string:concat(?MODULE:newsdb_url(), "_design/video_design/_view/"),
	Url2 = string:concat(Url1, Category),	
	string:concat(Url2, "?descending=true&limit=1")
.
% popular_videos(Category, Limit, Skip) ->
% 	Url  = string:concat(?MODULE:newsdb_url(), "_design/popular_videos/_view/"), 
% 	Url1 = string:concat(Url,Category ),	
% 	Url3 = string:concat(Url1, "?descending=true&limit="),
% 	Url4 = string:concat(Url3, Limit),
% 	Url5 = string:concat(Url4, "&skip="),
% 	string:concat(Url5, Skip).
popular_videos(Category, Limit, Skip) ->
	Url  = string:concat(?MODULE:newsdb_url(), "_design/video_world_news/_view/"), 
	Url1 = string:concat(Url,Category ),	
	Url3 = string:concat(Url1, "?descending=true&limit="),
	Url4 = string:concat(Url3, Limit),
	Url5 = string:concat(Url4, "&skip="),
	string:concat(Url5, Skip).
more_videos(Limit, Skip) ->
	Url  = string:concat(?MODULE:newsdb_url(), "_design/video_world_news/_view/"), 
	Url1 = string:concat(Url,"by_id_title_desc_thumb_date"),	
	Url3 = string:concat(Url1, "?descending=true&limit="),
	Url4 = string:concat(Url3, Limit),
	Url5 = string:concat(Url4, "&skip="),
	string:concat(Url5, Skip).
more_videos_pagination(Category,Limit, Skip) ->
	Url  = string:concat(?MODULE:newsdb_url(), "_design/video_world_news/_view/"), 
	Url1 = string:concat(Url,Category),	
	Url3 = string:concat(Url1, "?descending=true&limit="),
	Url4 = string:concat(Url3, Limit),
	Url5 = string:concat(Url4, "&skip="),
	string:concat(Url5, Skip).


 video_count(Category, Limit, Skip) ->
	% Url1 = string:concat(?MODULE:newsdb_url(),"_design/home_video/_view/"),
	Url1 = string:concat(?MODULE:newsdb_url(),"_design/video_world_news/_view/"),
	Url2 = string:concat(Url1, Category),
	Url3 = string:concat(Url2, "?descending=true&limit="),
	Url4 = string:concat(Url3, Limit),
	Url5 = string:concat(Url4, "&skip="),
	string:concat(Url5, Skip)
.
video_data(Doc_id) ->
	string:concat(?MODULE:newsdb_url(), Doc_id)
.

