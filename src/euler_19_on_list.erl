-module(euler_19_on_list).
-export([start/0, solve/2]).

start() ->
  solve(1901, 2000).

solve(StartYear, EndYear) ->
  length([ 1 || Y <- lists:seq(StartYear, EndYear),
    M <- lists:seq(1, 12),
    calendar:day_of_the_week(Y,M,1) =:= 7 ]).
