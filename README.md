# Laboratory course. Functional programming.

## 12 Euler problem
The sequence of triangle numbers is generated by adding the natural numbers. So the 7th triangle number would be <br/>
```1 + 2 + 3 + 4 + 5 + 6 + 7 = 28```. <br/>
The first ten terms would be:  <br/>
```1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...``` <br/>

Let us list the factors of the first seven triangle numbers: <br/>
```
 1: 1
 3: 1,3
 6: 1,2,3,6
10: 1,2,5,10
15: 1,3,5,15
21: 1,3,7,21
28: 1,2,4,7,14,28
```
We can see that 28 is the first triangle number to have over five divisors. <br/>

What is the value of the first triangle number to have over five hundred divisors? <br/>

1) Implement alghorithm that counts divisors of number: <br/>
```Erlang
divisors(N) ->
  NumFactors = length([X || X <- lists:seq(1, round(math:sqrt(N))), N rem X =:= 0]),
  case N == math:sqrt(N) * math:sqrt(N) of
    true -> NumFactors * 2 - 1;
    false -> NumFactors * 2
  end.
```
2) Implement alghoritm that finding triangle numbers: <br/>
```Erlang
triangular_number(N) ->
  N * (N + 1) div 2.
```
3) Search a triangle number that have >500 divisors: <br/>
```Erlang
find_triangular_num_with_n_divisors(TriNum, N) ->
  case divisors(triangular_number(TriNum)) > N of
    true -> triangular_number(TriNum);
    false -> find_triangular_num_with_n_divisors(TriNum + 1, N)
  end.
```

Also, solution with generators:
```Erlang
find_triangular_num_with_n_divisors(TriNum, N) ->
  case divisors(triangular_number(TriNum)) > N of
    true -> triangular_number(TriNum);
    false -> -1
  end.

triangular_number(N) ->
  N * (N + 1) div 2.

divisors(N) ->
  NumFactors = length([X || X <- lists:seq(1, round(math:sqrt(N))), N rem X =:= 0]),
  case N == math:sqrt(N) * math:sqrt(N) of
    true -> NumFactors * 2 - 1;
    false -> NumFactors * 2
  end.

generate_next_permutation(Permutation, Limit) ->
  find_triangular_num_with_n_divisors(Permutation, Limit).

take_permutation(GeneratorPid, I, Limit) when I >= Limit - 1 -> next_permutation(GeneratorPid);

take_permutation(GeneratorPid, I, Limit) when I < Limit - 1 ->
  {_Next, Result} = next_permutation(GeneratorPid),
  case Result > 0 of
    true -> Result;
    false -> take_permutation(GeneratorPid, I + 1, Limit)
  end.

take_permutation(GeneratorPid, Limit) -> take_permutation(GeneratorPid, 1, Limit).

permutation_generator(Limit) ->
  permutation_generator(1, Limit).

permutation_generator(CurrentPermutation, Limit) ->
  receive
    {SenderPid, next} ->
      Result = generate_next_permutation(CurrentPermutation, Limit),
      SenderPid ! {CurrentPermutation + 1, Result},
      permutation_generator(CurrentPermutation + 1, Limit);

    close -> closed
  end.

create_permutation_generator(Limit) -> spawn(fun () -> permutation_generator(Limit) end).

close_permutation_generator(GeneratorPid) -> GeneratorPid ! close.

next_permutation(GeneratorPid) ->
  GeneratorPid ! {self(), next},
  receive {NextPermutation, Result} -> {NextPermutation, Result} after 3000 -> exit(timeout) end.

start_generator(Limit) ->
  GeneratorPid = create_permutation_generator(Limit),
  Permutations = take_permutation(GeneratorPid, ?MAX_GENERATOR_ITERATION),
  close_permutation_generator(GeneratorPid),
  Permutations.
```

First problem solved, lets go to the next.

## 19 Euler problem
You are given the following information, but you may prefer to do some research for yourself.

* 1 Jan 1900 was a Monday.
Thirty days has September, <br/>
April, June and November. <br/>
All the rest have thirty-one, <br/>
Saving February alone, <br/>
Which has twenty-eight, rain or shine. <br/>
And on leap years, twenty-nine. <br/>
* A leap year occurs on any year evenly divisible by 4, <br/>
but not on a century unless it is divisible by 400.
<br/>
How many Sundays fell on the first of the month during the twentieth century (1 Jan 1901 to 31 Dec 2000)?

1) We should know its leap year or not:
```Erlang
is_leap_year(Y) when Y rem 400 =:= 0 ->
  true;
is_leap_year(Y) when Y rem 100 =:= 0 ->
  false;
is_leap_year(Y) when Y rem 4 =:= 0 ->
  true;
is_leap_year(_) ->
  false.
```
2) We should know how many days in months:
```Erlang
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
```
3) We should count amount of sundays that fell on the first of the month:
```Erlang
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
```

Also, solution on lists functions
```Erlang
start() ->
  solve(1901, 2000).

solve(StartYear, EndYear) ->
  length([ 1 || Y <- lists:seq(StartYear, EndYear),
    M <- lists:seq(1, 12),
    calendar:day_of_the_week(Y,M,1) =:= 7 ]).
```
