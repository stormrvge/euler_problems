-module(euler_12_genarator).
-export([start/0, start_generator/1]).

-define(MAX_GENERATOR_ITERATION, 100000000).

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

start() ->
  start_generator(500).
