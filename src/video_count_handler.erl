-module(video_count_handler).
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
	% lager:info("Get total number of Videos"),
	% {ok, "200", _, Response} = ibrowse:send_req("http://localhost:5984/speakglobally/_design/get_count/_view/all_docs",[],get,[],[]),
	% {ok, "200", _, Response} = ibrowse:send_req("http://couchdb.speakglobally.net/speakglobally/_design/get_count/_view/all_docs",[],get,[],[]),
	% Res = string:sub_string(Response, 1, string:len(Response) -1 ),
	% Body = list_to_binary(Res),
	% {Body, Req, State}.

	{Category, _ } = cowboy_req:qs_val(<<"c">>, Req),
	{Limit, _ } = cowboy_req:qs_val(<<"l">>, Req),
	{Skip, _ } = cowboy_req:qs_val(<<"skip">>, Req),
	Url = sglobally_util:popular_videos(binary_to_list(Category), binary_to_list(Limit), binary_to_list(Skip)),
	% io:format("Url--> ~p ~n ",[Url]),
	{ok, "200", _, Response} = ibrowse:send_req(Url,[],get,[],[]),
	Res = string:sub_string(Response, 1, string:len(Response) -1 ),
	Body = list_to_binary(Res),
	{Body, Req, State}.


