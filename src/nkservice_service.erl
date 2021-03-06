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

-module(nkservice_service).
-author('Carlos Gonzalez <carlosj.gf@gmail.com>').


%% ===================================================================
%% Callbacks
%% ===================================================================

-callback get_syntax() ->
    map().

-callback update(nkservice:id(), nkservice:spec()) ->
	{ok, nkservice:info()}.

-callback remove(nkservice:obj_id()) ->
	ok.




%% ===================================================================
%% Sample
%% ===================================================================
