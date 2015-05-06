-module(videos_non_featured_handler).
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

	% lager:info("List of Non featured videos requested"),
	%{[{_,Page}], Req2} = cowboy_req:bindings(Req),
	%{QueryString, Req1 } = cowboy_req:qs(Req),
	% {Skip, _ } = cowboy_req:qs_val(<<"skip">>, Req),
	% {Limit, _ } = cowboy_req:qs_val(<<"limit">>, Req) ,

	% Url = sglobally_util:more_videos(binary_to_list(Limit), binary_to_list(Skip)),
	% io:format("params ~p ~n ",[Url]),
	% {ok, "200", _, Response} = ibrowse:send_req(Url,[],get,[],[]),
	% Res = string:sub_string(Response, 1, string:len(Response) -1 ),
	% Body = list_to_binary(Res),
	% {Body, Req, State}. 

	Url = "http://api.contentapi.ws/videos?channel=world_news&limit=42&skip=1&format=short",
	{ok, "200", _, Response_mlb} = ibrowse:send_req(Url,[],get,[],[]),
	Body = list_to_binary(Response_mlb),
	{Body, Req, State}.

 %    Url = string:join(["http://couchdb.speakglobally.net/speakglobally/_design/get_videos/_view/by_id_title_thumbs_duration?descending=true&limit=", binary_to_list(Limit),"&skip=",binary_to_list(Skip)],""),	
 %    % Url = string:join(["http://localhost:5984/speakglobally/_design/get_videos/_view/by_id_title_thumbs_duration?descending=true&limit=", binary_to_list(Limit),"&skip=",binary_to_list(Skip)],""),	
	% {ok, "200", _, Response} = ibrowse:send_req(Url,[],get,[],[]),
	% Res = string:sub_string(Response, 1, string:len(Response) -1 ),
	% Body = list_to_binary(Res),
	% {Body, Req, State}.


