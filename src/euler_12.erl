-module(euler_12).
-export([solve/0, solve/1, solve/2]).

triangle_number(N) -> lists:sum(lists:seq(1, N)).

divisors(N) -> divisors(N, lists:seq(1, round(math:sqrt(N)))).

divisors(N, [H|T]) ->
  case N rem H of
    0 -> [H, N div H | divisors(N, T)];
    _ -> divisors(N, T)
  end;
divisors(_N, []) -> [].

solve() -> solve(1, 500).
solve(Limit) -> solve(1, Limit).
solve(N, Limit) ->
  Triangle = triangle_number(N),
  Divisors = divisors(Triangle),
  case length(Divisors) of
    L when L > Limit -> Triangle;
    _ -> solve(N + 1, Limit)
  end.
