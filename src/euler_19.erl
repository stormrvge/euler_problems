-module(euler_19).
-export([start/0, solve/2]).

start() ->
  solve(1901, 2000).

solve(StartYear, EndYear) ->
  {Year, Month, Day} = {StartYear, 1, 1},
  solve(Year, Month, Day, 0, EndYear).

solve(Year, Month, Day, Sundays, EndYear) ->
  DaysInMonth = days_in_month(Month, Year),
  NextMonth = (Month rem 12) + 1,
  NextYear = case NextMonth =:= 1 of
               true -> Year + 1;
               false -> Year
             end,
  NextDay = (Day + DaysInMonth) rem 7,
  case NextYear of
    EndYear -> Sundays;
    _ -> case Day =:= 0 of
           true -> solve(NextYear, NextMonth, NextDay, Sundays + 1, EndYear);
           false -> solve(NextYear, NextMonth, NextDay, Sundays, EndYear)
         end
  end.


days_in_month(Year, Month) ->
  case is_leap_year(Year) of
    true -> days_in_month(leap_year, Month, Year);
    false -> days_in_month(not_leap_year, Month, Year)
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
