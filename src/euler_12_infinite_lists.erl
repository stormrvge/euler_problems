-module(euler_12_infinite_lists).
-export([solve/0, solve/2]).

solve() -> solve(1, 500).

solve(N, Limit) ->
  T = ((N * (N + 1)) div 2),
  D = (2 * length([X || X <- lists:seq(1, erlang:trunc(math:sqrt(T))), (T rem X) =:= 0])),
  case D > Limit of
    true -> T;
    false -> solve(N + 1, Limit)
  end.
