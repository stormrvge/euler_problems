-module(euler_12).

-export([solve/0]).

divisors(N) -> divisors(N, 1, []).

divisors(N, I, Divisors) when I > (N div 2) -> lists:reverse(Divisors);
divisors(N, I, Divisors) when N rem I == 0 -> divisors(N, I + 1, [I | Divisors]);
divisors(N, I, Divisors) -> divisors(N, I + 1, Divisors).

solve() -> solve(1, 0).

solve(N, T) ->
  io:format("T = ~w\n", [T]),
  case length(divisors(T)) > 500 of
    true -> T;
    false -> solve(N + 1, T + N)
  end.
