-module(euler_19_list_filter).
-export([start/0, solve/2]).

start() ->
  solve(1901, 2000).

solve(StartYear, EndYear) ->
  length(lists:filter(fun is_sunday_and_first_of_month/1, get_days_from_till({StartYear, 1, 1}, {EndYear, 12, 31}))).

get_days_from_till(X, X) ->
  [X];
get_days_from_till(From, Till) ->
  [From] ++ get_days_from_till(calendar:gregorian_days_to_date(calendar:date_to_gregorian_days(From) + 1), Till).

is_sunday_and_first_of_month({Year, Month, 1}) ->
  7 == calendar:day_of_the_week({Year, Month, 1});
is_sunday_and_first_of_month(_) ->
  false.

