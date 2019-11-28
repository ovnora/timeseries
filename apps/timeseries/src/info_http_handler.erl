-module(info_http_handler).

-include_lib("timeseries.hrl").

-export([init/2]).

%%%=============================================================================
%%% API functions
%%%=============================================================================

%%------------------------------------------------------------------------------
%% @doc Cowboy `init' callback
%% @end
%%------------------------------------------------------------------------------
-spec init(Request, Arguments) -> Result when
      Request :: cowboy_req:req(),
      Arguments :: [],
      Result :: {ok, Request, noop}.
init(Request0, []) ->
    ?LOG_NOTICE(#{msg => "Initialize"}),

    {ok, Info} = timeseries_server:info(),

    Headers = #{<<"content-type">> => <<"application/msgpack">>},
    Body = msgpack:pack(Info),
    Request = cowboy_req:reply(200, Headers, Body, Request0),

    {ok, Request, noop}.

