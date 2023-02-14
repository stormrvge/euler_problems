-module(modules_test).

-import(euler_19, [start/0, run_solve/2]).

-include_lib("eunit/include/eunit.hrl").

sunday_count_test() ->
  ?assertEqual(86, euler_19:run_solve(1800, 1850)),
  ?assertEqual(101, euler_19:run_solve(1901, 1960)),
  ?assertEqual(118, euler_19:run_solve(1901, 1970)),
  ?assertEqual(135, euler_19:run_solve(1901, 1980)),
  ?assertEqual(171, euler_19:run_solve(1901, 2001)).

triangle_number_test() ->
  ?assertEqual(120, euler_12:solve(10)),
  ?assertEqual(2016, euler_12:solve(30)),
  ?assertEqual(5460, euler_12:solve(45)),
  ?assertEqual(73920, euler_12:solve(100)),
  ?assertEqual(2031120, euler_12:solve(200)),
  ?assertEqual(76576500, euler_12:solve(500)).