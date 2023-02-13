-module(modules_test).

-import(euler_19, [start/0, solve/2]).

-include_lib("eunit/include/eunit.hrl").

sunday_count_test() ->
  ?assertEqual(86, euler_19:solve(1800, 1850)),
  ?assertEqual(101, euler_19:solve(1901, 1960)),
  ?assertEqual(118, euler_19:solve(1901, 1970)),
  ?assertEqual(135, euler_19:solve(1901, 1980)),
  ?assertEqual(171, euler_19:solve(1901, 2001)).
