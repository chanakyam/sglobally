-module(videos_popular_handler).
-author("chanakyam@koderoom.com").

-export([init/3]).

-export([content_types_provided/2]).
-export([welcome/2]).
-export([terminate/3]).

%% Init
init(_Transport, _Req, []) ->
	{upgrade, protocol, cowboy_rest}.

%% Callbacks
content_types_provided(Req, State) ->
	{[		
		{<<"application/json">>, welcome}	
	], Req, State}.

terminate(_Reason, _Req, _State) ->
	ok.

%% API
welcome(Req, State) ->
	% {Category, _ } = cowboy_req:qs_val(<<"c">>, Req),
	% {Limit, _ } = cowboy_req:qs_val(<<"l">>, Req),
	% {Skip, _ } = cowboy_req:qs_val(<<"skip">>, Req),

	% Url = sglobally_util:popular_videos(binary_to_list(Category), binary_to_list(Limit), binary_to_list(Skip)),
	% % io:format("Url--> ~p ~n ",[Url]),
	% {ok, "200", _, Response} = ibrowse:send_req(Url,[],get,[],[]),
	% Res = string:sub_string(Response, 1, string:len(Response) -1 ),
	% Body = list_to_binary(Res),
	% {Body, Req, State}.

	Url = "http://api.contentapi.ws/videos?channel=world_news&limit=4&skip=4&format=short",
	{ok, "200", _, Response_mlb} = ibrowse:send_req(Url,[],get,[],[]),
	Body = list_to_binary(Response_mlb),
	{Body, Req, State}.

	% lager:info("List of Popular videos requested"),
	% {Count, _} = cowboy_req:qs_val(<<"n">>, Req),
	% % Url = string:concat("http://couchdb.speakglobally.net/_design/popular_videos/_view/by_id_title_thumb_duration?descending=true&limit=", binary_to_list(Count)), 
	% Url = string:concat("http://localhost:5984/speakglobally/_design/popular_videos/_view/by_id_title_thumb_duration?descending=true&limit=", binary_to_list(Count)),
	% {ok, "200", _, Response} = ibrowse:send_req(Url,[],get,[],[]),
	% Res = string:sub_string(Response, 1, string:len(Response) -1 ),
	% Body = list_to_binary(Res),
	% {Body, Req, State}.

