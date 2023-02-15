-module(modules_test).

-import(euler_19, [start/0, run_solve/2]).

-include_lib("eunit/include/eunit.hrl").

sunday_count_test() ->
  ?assertEqual(86, euler_19:run_solve(1800, 1850)),
  ?assertEqual(102, euler_19:run_solve(1901, 1960)),
  ?assertEqual(118, euler_19:run_solve(1901, 1970)),
  ?assertEqual(135, euler_19:run_solve(1901, 1980)),
  ?assertEqual(171, euler_19:run_solve(1901, 2001)).

leap_year_test() ->
  ?assertEqual(true, euler_19:is_leap_year(28)),
  ?assertEqual(false, euler_19:is_leap_year(29)).

find_triangular_num_with_n_divisors_test() ->
  ?assertEqual(120, euler_12:solve(10)),
  ?assertEqual(2016, euler_12:solve(30)),
  ?assertEqual(5460, euler_12:solve(45)),
  ?assertEqual(73920, euler_12:solve(100)),
  ?assertEqual(2031120, euler_12:solve(200)),
  ?assertEqual(76576500, euler_12:solve(500)).

triangular_number_test() ->
  ?assertEqual(28, euler_12:triangular_number(7)),
  ?assertEqual(120, euler_12:triangular_number(15)),
  ?assertEqual(210, euler_12:triangular_number(20)),
  ?assertEqual(1275, euler_12:triangular_number(50)),
  ?assertEqual(5050, euler_12:triangular_number(100)),
  ?assertEqual(20100, euler_12:triangular_number(200)).

divisors_test() ->
  ?assertEqual(1, euler_12:divisors(1)),
  ?assertEqual(2, euler_12:divisors(2)),
  ?assertEqual(3, euler_12:divisors(4)),
  ?assertEqual(2, euler_12:divisors(5)),
  ?assertEqual(2, euler_12:divisors(7)),
  ?assertEqual(6, euler_12:divisors(12)),
  ?assertEqual(12, euler_12:divisors(60)).
