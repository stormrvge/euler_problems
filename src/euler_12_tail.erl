-module(euler_12_tail).
-export([start/0, solve/1, triangular_number/1, divisors/1]).

start() ->
  N = 500,
  find_triangular_num_with_n_divisors(N).

solve(N) ->
  find_triangular_num_with_n_divisors(N).

find_triangular_num_with_n_divisors(N) ->
  find_triangular_num_with_n_divisors(1, N).

find_triangular_num_with_n_divisors(TriNum, N) ->
  case divisors(triangular_number(TriNum)) > N of
    true -> triangular_number(TriNum);
    false -> find_triangular_num_with_n_divisors(TriNum + 1, N)
  end.

triangular_number(N) ->
  N * (N + 1) div 2.

divisors(N) ->
  NumFactors = length([X || X <- lists:seq(1, round(math:sqrt(N))), N rem X =:= 0]),
  case N == math:sqrt(N) * math:sqrt(N) of
    true -> NumFactors * 2 - 1;
    false -> NumFactors * 2
  end.
