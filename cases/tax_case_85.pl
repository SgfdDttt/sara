% Text
% In 2019, Alice was paid $34510. Alice has a brother, Charlie, whose son Bob lived at Alice's place in 2019, a house that she maintains. In 2019, Charlie had a different principal place of abode, and Bob had no income. Alice takes the standard deduction in 2019.

% Question
% How much tax does Alice have to pay in 2019? $2477

% Facts
:- [statutes/prolog/init].
payment_(alice_is_paid).
patient_(alice_is_paid,alice).
start_(alice_is_paid,"2019-12-31").
amount_(alice_is_paid,34510).
brother_(charlie_brother).
agent_(charlie_brother,charlie).
patient_(charlie_brother,alice).
son_(bob_is_son).
agent_(bob_is_son,bob).
patient_(bob_is_son,charlie).
residence_(bob_residence).
agent_(bob_residence,bob).
patient_(bob_residence,alice_house).
start_(bob_residence,"2019-01-01").
end_(bob_residence,"2019-12-31").
residence_(alice_residence).
agent_(alice_residence,alice).
patient_(alice_residence,alice_house).
start_(alice_residence,"2019-01-01").
end_(alice_residence,"2019-12-31").
payment_(alice_maintains_house).
agent_(alice_maintains_house,alice).
amount_(alice_maintains_house,1).
start_(alice_maintains_house,"2019-01-01").
purpose_(alice_maintains_house,alice_house).
residence_(charlie_residence).
agent_(charlie_residence,charlie).
patient_(charlie_residence,charlie_house).
start_(charlie_residence,"2019-01-01").
end_(charlie_residence,"2019-12-31").

% Test
:- tax(alice,2019,2477).
:- halt.
