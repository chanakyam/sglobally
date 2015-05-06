-module(sglobally_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
	Dispatch = cowboy_router:compile([
        {'_',[
                {"/", home_page_handler, []},
                {"/api/home", site_root_handler, []},			                
                {"/api/videos/featured_none", videos_non_featured_handler, []},
				{"/api/videos/popular", videos_popular_handler, []},
                {"/api/videos/latest", videos_latest_handler, []},
                {"/api/videos/count", video_count_handler, []},
                {"/video", video_page_handler, []},
                {"/more_videos", more_videos_handler, []},
                {"/terms", tnc_page_handler, []},
                {"/privacy", privacy_page_handler, []},

                %%
                %% Release Routes
                %%
                {"/css/[...]", cowboy_static, {priv_dir, sglobally, "static/css"}},
                {"/images/[...]", cowboy_static, {priv_dir, sglobally, "static/images"}},
                {"/js/[...]", cowboy_static, {priv_dir, sglobally, "static/js"}},
                {"/fonts/[...]", cowboy_static, {priv_dir, sglobally, "static/fonts"}}
                % %%
                %% Dev Routes
                %%
                % {"/css/[...]", cowboy_static, {dir, "priv/static/css"}},
                % {"/images/[...]", cowboy_static, {dir, "priv/static/images"}},
                % {"/js/[...]", cowboy_static, {dir,"priv/static/js"}},
                % {"/fonts/[...]", cowboy_static, {dir, "priv/static/fonts"}}
        ]}      
    ]),    

    {ok, _} = cowboy:start_http(http,100, [{port, 10002}],[{env, [{dispatch, Dispatch}]}
              ]),
    sglobally_sup:start_link().

stop(_State) ->
    ok.
