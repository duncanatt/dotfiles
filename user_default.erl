-module(user_default).

-export([lm/0, cm/0, cm/1]).

lm() ->
  [purge_load(F) || F <- (fun() -> List = filelib:wildcard("*.beam"), lists:map(fun(I) -> list_to_atom(lists:takewhile(fun(C) -> C =/= $. end, I)) end, List) end)()].

cm() ->
  [compile:file(F) || F <- (fun() -> List = filelib:wildcard("*.erl"), lists:map(fun(I) -> list_to_atom(lists:takewhile(fun(C) -> C =/= $. end, I)) end, List) end)()].

cm(IncList) when is_list(IncList) ->
  Inc = [{i, I} || I <- IncList],
  io:format("Including files: ~p~n", [Inc]), 
  [compile:file(F, Inc) || F <- (fun() -> List = filelib:wildcard("*.erl"), lists:map(fun(I) -> list_to_atom(lists:takewhile(fun(C) -> C =/= $. end, I)) end, List) end)()].

purge_load(M) ->
  code:purge(M), code:load_file(M).