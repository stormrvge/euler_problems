-module(euler_19_tail).
-export([start/0, is_leap_year/1, run_solve/2, days_in_month/2]).

start() ->
  run_solve(1901, 2001).

run_solve(StartYear, EndYear) ->
  StartPid = self(),
  spawn(fun() -> solve(StartYear, EndYear, StartPid) end),
  receive
    {StartPid, Result} -> Result
  end.

solve(StartYear, EndYear, StartPid) ->
  {Year, Month, Day} = {StartYear, 1, 2},
  Result = solve(Year, Month, Day, 0, EndYear),
  StartPid ! {StartPid, Result}.

solve(Year, Month, Day, Sundays, EndYear) ->
  DaysInMonth = days_in_month(Month, Year),
  NextMonth = (Month rem 12) + 1,
  NextYear = case {NextMonth, Year} of
               {1, Y} -> Y + 1;
               {_, Y} -> Y
             end,
  NextDay = (Day + DaysInMonth) rem 7,
  case NextYear of
    EndYear -> Sundays;
    _ -> case Day =:= 0 of
           true -> solve(NextYear, NextMonth, NextDay, Sundays + 1, EndYear);
           false -> solve(NextYear, NextMonth, NextDay, Sundays, EndYear)
         end
  end.

days_in_month(Month, Year) ->
  case is_leap_year(Year) of
    true -> days_in_month(leap_year, Year, Month);
    false -> days_in_month(not_leap_year, Year, Month)
  end.

days_in_month(not_leap_year, _Year, Month) ->
  case lists:member(Month, [1, 3, 5, 7, 8, 10, 12]) of
    true -> 31;
    false -> case lists:member(Month, [4, 6, 9, 11]) of
               true -> 30;
               false -> 28
             end
  end;
days_in_month(leap_year, _Year, Month) ->
  case lists:member(Month, [1, 3, 5, 7, 8, 10, 12]) of
    true -> 31;
    false -> case lists:member(Month, [4, 6, 9, 11]) of
               true -> 30;
               false -> 29
             end
  end.

is_leap_year(Y) when Y rem 400 =:= 0 ->
  true;
is_leap_year(Y) when Y rem 100 =:= 0 ->
  false;
is_leap_year(Y) when Y rem 4 =:= 0 ->
  true;
is_leap_year(_) ->
  false.
