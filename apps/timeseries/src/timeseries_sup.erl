%%%-----------------------------------------------------------------------------
%%% Copyright (C) 2020 Törteli Olivér Máté <tortelio@yahoo.com>
%%%
%%% All rights reserved.
%%%-----------------------------------------------------------------------------
%%% @doc timeseries top level supervisor.
%%% @end
%%%-----------------------------------------------------------------------------

-module(timeseries_sup).

-behaviour(supervisor).

%%%=============================================================================
%%% Exports
%%%=============================================================================

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

%%%=============================================================================
%%% Macros
%%%=============================================================================

-define(SERVER, ?MODULE).

%%%=============================================================================
%%% API functions
%%%=============================================================================

%%------------------------------------------------------------------------------
%% @doc Start supervisor.
%% @end
%%------------------------------------------------------------------------------
-spec start_link() -> Result when
      Result :: supervisor:startlink_ret().
start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%%%=============================================================================
%%% Supervisor callbacks
%%%=============================================================================

%%------------------------------------------------------------------------------
%% @doc Initialize supervisor.
%% @end
%%------------------------------------------------------------------------------
init([]) ->
    ChildSpecs = [#{id => timeseries_server,
                    start => {timeseries_server, start_link, []}}
                 ],
    {ok, {{one_for_all, 0, 1}, ChildSpecs}}.
