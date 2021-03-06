%% -------------------------------------------------------------------
%%
%% Copyright (c) 2015 Carlos Gonzalez Florido.  All Rights Reserved.
%%
%% This file is provided to you under the Apache License,
%% Version 2.0 (the "License"); you may not use this file
%% except in compliance with the License.  You may obtain
%% a copy of the License at
%%
%%   http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing,
%% software distributed under the License is distributed on an
%% "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
%% KIND, either express or implied.  See the License for the
%% specific language governing permissions and limitations
%% under the License.
%%
%% -------------------------------------------------------------------

-module(nkservice_syntax).
-author('Carlos Gonzalez <carlosj.gf@gmail.com>').

-export([app_syntax/0, app_defaults/0, syntax/0, defaults/0]).

-include_lib("nkpacket/include/nkpacket.hrl").
  

%% @private
app_syntax() ->
    #{
        log_path => binary
    }.



%% @private
app_defaults() ->    
    #{
        log_path => <<"log">>
    }.



%% @private
syntax() ->
    #{
        id => atom,
        name => any,
        class => atom,
        plugins => {list, atom},
        callback => atom,
        log_level => log_level,
        transports => fun parse_transports/3,

        idle_timeout => pos_integer,
        connect_timeout => nat_integer,
        sctp_out_streams => nat_integer,
        sctp_in_streams => nat_integer,
        no_dns_cache => boolean,
        ?TLS_SYNTAX
    }.



%% @private
defaults() ->    
    #{
        log_level => notice
    }.



%% @private
parse_transports(_, [{_, _, _, _, _}|_]=List, _) ->
   List1 = [
        {[{Protocol, Transp, Ip, Port}], Opts}
        || {Protocol, Transp, Ip, Port, Opts} <- List
    ],
    {ok, List1};

parse_transports(_, Spec, _) ->
    case nkpacket:multi_resolve(Spec, #{resolve_type=>listen}) of
        {ok, List} ->
            {ok, List};
        _ ->
            error
    end.


