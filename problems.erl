-module(problems).
-compile(export_all).

% P01
find_last([H]) ->
  H;
find_last([_H|T]) ->
  find_last(T).
  
% P02
find_last_but_one([H|[_T]]) ->
  H;
find_last_but_one([_H|T]) ->
  find_last_but_one(T).

% P03
element_at(List, Pos) ->
  element_at(List, Pos, 1).
  
element_at([H|_T], Pos, Pos) ->
  H;
element_at([_H|T], Pos, Ac) ->
  element_at(T, Pos, Ac + 1).

% P03 rework - less verbose
element_at2([H|_T], 1) ->
  H;
element_at2([_H|T], Pos) ->
  element_at2(T, Pos - 1).

% P04
num_elements(List) ->
  num_elements(List, 0).

num_elements([], Acc) ->
  Acc;
num_elements([_H|T], Acc) ->
  num_elements(T, Acc + 1).

% P05
rev([]) ->
  [];
rev([H|T]) ->
  rev(T) ++ [H].

% tail recursive
list_rev(List) ->
  list_rev(List, []).

list_rev([], Acc) ->
  Acc;
list_rev([H|T], Acc) ->
  list_rev(T, [H|Acc]).

% P06
 
is_palindrome(List) ->
  List =:= rev(List).
  
% pattern matching only
is_palindrome2(List) ->
  Reverse = rev(List),
  case {List, Reverse} of
    {[_], _} ->
      true;
    {[], _} ->
      true;
    {[H|T], [H|_]} ->
      is_palindrome2(lists:sublist(T, length(T) - 1));
    {_, _} ->
      false
  end.

% P07
flatten([]) ->
  [];
flatten([H|T]) ->
  flatten(H) ++ flatten(T);
flatten(H) ->
  [H].
 
% P08
compress(List) ->
  compress(List, []).

compress([], Acc) ->
  Acc;
compress([H,H|T], Acc) ->
  compress([H|T], Acc);
compress([H|T], Acc) ->
  compress(T, Acc ++ [H]).


% P09
pack([H|T]) ->
  pack(T, [H], []).

pack([], Dups, Acc) ->
  Acc ++ [Dups];
pack([H|T], [H|DupTail], Acc) ->
  pack(T, [H|DupTail] ++ [H], Acc);
pack([H|T], Dups, Acc) ->
  pack(T, [H], Acc ++ [Dups]).
 
  
% P10
encode(List) ->
  lists:map(fun([H|T]) -> [length([H|T]), H] end, pack(List)).

% using list comprehensions
encode2(List) ->
  [[length([H|T]), H] || [H|T] <- pack(List)].


% P11
encode_modified(List) ->
  lists:map(fun
      ([X]) -> X;
      ([H|T]) -> [length([H|T]), H] end, pack(List)).

% P12
decode2(List) ->
    NewList = lists:map(fun
        ([Length|Element]) -> decode_item(Element,Length, []);
        (Element) -> Element end, List),
    flatten(NewList).

decode_item(_Element, 0, Acc) ->
    Acc;
decode_item(Element, Length, Acc) ->
    decode_item(Element, Length - 1, [Element|Acc]).
    

% P13
encode_direct(List) ->
    encode_direct(List, 1, []).

encode_direct([], _, Acc) ->
    Acc;
    
encode_direct([H,H|T], N, Acc) ->
    encode_direct(T, N + 2, Acc);
    
% singleton items should not be a sub-array
encode_direct([H|T], N, Acc) when N =:= 1 ->
    encode_direct(T, 1, [H|Acc]);
encode_direct([H|T], N, Acc) ->
    encode_direct(T, 1, [[N,H]|Acc]).


% P14
dupli([]) ->
    [];
dupli([H|T]) ->
    [H,H | dupli(T)].
    

% P15
% like P14 but with number of duplicates specified and tail recursive.

dupli(List, Times) ->
    dupli(List, Times, Times, []).

dupli([], _, _, Acc) ->
    Acc;
dupli([_|T], 0, Times, Acc) ->
    dupli(T, Times, Times, Acc);
dupli([H|T], Counter, Times, Acc) ->
    dupli([H|T], Counter - 1, Times, [H|Acc]).
    
% P16
drop(List, Nth) ->
    drop(List, Nth, Nth).

drop([], _, _) ->
    [];
    
% drop item and reset counter 
drop([_|T], Nth, 0) ->
    drop(T, Nth, Nth);
    
drop([H|T], Nth, Counter) ->
    [H] ++ (drop(T, Nth, Counter - 1)).
    
  

  