-module(modules_test).

-import(euler_19, [start/0, run_solve/2]).

-include_lib("eunit/include/eunit.hrl").

sunday_count_test() ->
  ?assertEqual(86, euler_19_tail:run_solve(1800, 1850)),
  ?assertEqual(102, euler_19_tail:run_solve(1901, 1960)),
  ?assertEqual(118, euler_19_tail:run_solve(1901, 1970)),
  ?assertEqual(135, euler_19_tail:run_solve(1901, 1980)),
  ?assertEqual(171, euler_19_tail:run_solve(1901, 2001)),
  ?assertEqual(86, euler_19_non_tail:run_solve(1800, 1850)),
  ?assertEqual(102, euler_19_non_tail:run_solve(1901, 1960)),
  ?assertEqual(118, euler_19_non_tail:run_solve(1901, 1970)),
  ?assertEqual(135, euler_19_non_tail:run_solve(1901, 1980)),
  ?assertEqual(171, euler_19_non_tail:run_solve(1901, 2001)),
  ?assertEqual(86, euler_19_list_filter:solve(1800, 1849)),
  ?assertEqual(102, euler_19_list_filter:solve(1901, 1959)),
  ?assertEqual(118, euler_19_list_filter:solve(1901, 1969)),
  ?assertEqual(135, euler_19_list_filter:solve(1901, 1979)),
  ?assertEqual(171, euler_19_list_filter:solve(1901, 2000)).


leap_year_test() ->
  ?assertEqual(true, euler_19_tail:is_leap_year(2000)),
  ?assertEqual(false, euler_19_tail:is_leap_year(2001)).

find_triangular_num_with_n_divisors_test() ->
  ?assertEqual(120, euler_12_tail:solve(10)),
  ?assertEqual(2016, euler_12_tail:solve(30)),
  ?assertEqual(5460, euler_12_tail:solve(45)),
  ?assertEqual(73920, euler_12_tail:solve(100)),
  ?assertEqual(2031120, euler_12_tail:solve(200)),
  ?assertEqual(76576500, euler_12_tail:solve(500)),
  ?assertEqual(120, euler_12_genarator:start_generator(10)),
  ?assertEqual(2016, euler_12_genarator:start_generator(30)),
  ?assertEqual(5460, euler_12_genarator:start_generator(45)),
  ?assertEqual(73920, euler_12_genarator:start_generator(100)),
  ?assertEqual(2031120, euler_12_genarator:start_generator(200)),
  ?assertEqual(76576500, euler_12_genarator:start_generator(500)).

triangular_number_test() ->
  ?assertEqual(28, euler_12_tail:triangular_number(7)),
  ?assertEqual(120, euler_12_tail:triangular_number(15)),
  ?assertEqual(210, euler_12_tail:triangular_number(20)),
  ?assertEqual(1275, euler_12_tail:triangular_number(50)),
  ?assertEqual(5050, euler_12_tail:triangular_number(100)),
  ?assertEqual(20100, euler_12_tail:triangular_number(200)).

divisors_test() ->
  ?assertEqual(1, euler_12_tail:divisors(1)),
  ?assertEqual(2, euler_12_tail:divisors(2)),
  ?assertEqual(3, euler_12_tail:divisors(4)),
  ?assertEqual(2, euler_12_tail:divisors(5)),
  ?assertEqual(2, euler_12_tail:divisors(7)),
  ?assertEqual(6, euler_12_tail:divisors(12)),
  ?assertEqual(12, euler_12_tail:divisors(60)).
