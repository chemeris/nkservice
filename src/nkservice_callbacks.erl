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

%% @doc Default callbacks
-module(nkservice_callbacks).
-author('Carlos Gonzalez <carlosj.gf@gmail.com>').
-export([plugin_deps/0, plugin_parse/1, plugin_cache/1, plugin_transports/1]).
-export([plugin_start/1, plugin_stop/1]).
-export([service_init/2, service_handle_call/3, service_handle_cast/2, 
		 service_handle_info/2, service_code_change/3, service_terminate/2]).
-export_type([continue/0]).

-type user_spec() :: nkservice:user_spec().
-type service() :: nkservice:service().
-type continue() :: continue | {continue, list()}.


%% ===================================================================
%% Plugin Callbacks
%% ===================================================================

%% @doc Called to get the list of plugins this service/plugin depends on.
-spec plugin_deps() ->
    [module()].

plugin_deps() ->
	[].


%% @doc This function, if implemented, is called to parse the plugin options.
%% High level plugins have also the opportunity to modify the specification for lower
%% levels plugins
-spec plugin_parse(user_spec()) ->
	{ok, service()} | {error, term()}.

plugin_parse(UserSpec) ->
	{ok, UserSpec}.


%% @doc This function, if implemented, allows to select some values to be added to 
%% the module's cache. The plugin conf is stored under its key.
-spec plugin_cache(service()) ->
	{ok, map()}.

plugin_cache(_Service) ->
	#{}.


%% @doc This function, if implemented, allows to add transports
-spec plugin_transports(service()) ->
	list().

plugin_transports(_Service) ->
	[].


%% @doc Called during service's start
%% The plugin must start and store any state in the service map, under
%% its own key.
-spec plugin_start(service()) ->
	{ok, service()} | {error, term()}.

plugin_start(Service) ->
	{ok, Service}.


%% @doc Called during service's stop
%% The plugin must remove any key from the service
-spec plugin_stop(service()) ->
	{ok, service()}.

plugin_stop(Service) ->
	{ok, Service}.





%% ===================================================================
%% Service Callbacks
%% ===================================================================




%% @doc Called when a new service starts
-spec service_init(nkservice:spec(), service()) ->
	{ok, service()} | {stop, term()}.

service_init(_SrvSpec, State) ->
	{ok, State}.


%% @doc Called when the service process receives a handle_call/3.
-spec service_handle_call(term(), {pid(), reference()}, service()) ->
	{reply, term(), service()} | {noreply, service()} | continue().

service_handle_call(Msg, _From, State) ->
    lager:error("Module ~p received unexpected call ~p", [?MODULE, Msg]),
    {noreply, State}.


%% @doc Called when the NkApp process receives a handle_cast/3.
-spec service_handle_cast(term(), service()) ->
	{noreply, service()} | continue().

service_handle_cast(Msg, State) ->
    lager:error("Module ~p received unexpected cast ~p", [?MODULE, Msg]),
	{noreply, State}.


%% @doc Called when the NkApp process receives a handle_info/3.
-spec service_handle_info(term(), service()) ->
	{noreply, service()} | continue().

service_handle_info(Msg, State) ->
    lager:notice("Module ~p received unexpected info ~p", [?MODULE, Msg]),
	{noreply, State}.


-spec service_code_change(term()|{down, term()}, service(), term()) ->
    ok | {ok, service()} | {error, term()} | continue().

service_code_change(OldVsn, State, Extra) ->
	{continue, [OldVsn, State, Extra]}.


%% @doc Called when a service is stopped
-spec service_terminate(term(), service()) ->
	{ok, service()}.

service_terminate(_Reason, State) ->
	{ok, State}.



