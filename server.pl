/*
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/html_write)).
:- use_module(library(http/http_parameters)).
:- use_module(library(http/http_client)).
:- use_module(library(uri)).

:- use_module(library(http/json)).
:- use_module(library(http/http_json)).
:- use_module(library(http/json_convert)).

:- use_module(library(http/http_unix_daemon)).
:- initialization http_daemon.

:- http_handler('/metropolitana-milano', http_get_metropolitana_milano, []).

:- consult('main').
:- main.

http_get_metropolitana_milano(Request) :-
    http_parameters(Request,
            [
             from(From,   []),
             to(To,   [])
            ]),
    all_routes(From, To, Result),
    prolog_to_json(json([from=From,to=To,path=Result]), Json),
    reply_json(Json).
