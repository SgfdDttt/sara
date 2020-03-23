% Text
% In 2017, Alice was paid $75845. Alice has a son, Bob. From September 1st, 2015 to November 3rd, 2019, Alice and Bob lived in the same home, which Alice maintained. In 2017, Alice takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2017? $15037

% Facts
:- [statutes/prolog/init].
payment_(alice_is_paid).
patient_(alice_is_paid,alice).
start_(alice_is_paid,"2017-12-31").
amount_(alice_is_paid,75845).
son_(bob_is_son).
agent_(bob_is_son,bob).
patient_(bob_is_son,alice).
residence_(alice_residence).
agent_(alice_residence,alice).
patient_(alice_residence,home).
start_(alice_residence,"2015-09-01").
end_(alice_residence,"2019-11-03").
residence_(bob_residence).
agent_(bob_residence,bob).
patient_(bob_residence,home).
start_(bob_residence,"2015-09-01").
end_(bob_residence,"2019-11-03").
payment_(alice_maintains_2015).
agent_(alice_maintains_2015,alice).
amount_(alice_maintains_2015,1).
start_(alice_maintains_2015,"2015-09-01").
purpose_(alice_maintains_2015,home).
payment_(alice_maintains_2016).
agent_(alice_maintains_2016,alice).
amount_(alice_maintains_2016,1).
start_(alice_maintains_2016,"2016-01-01").
purpose_(alice_maintains_2016,home).
payment_(alice_maintains_2017).
agent_(alice_maintains_2017,alice).
amount_(alice_maintains_2017,1).
start_(alice_maintains_2017,"2017-01-01").
purpose_(alice_maintains_2017,home).
payment_(alice_maintains_2018).
agent_(alice_maintains_2018,alice).
amount_(alice_maintains_2018,1).
start_(alice_maintains_2018,"2018-01-01").
purpose_(alice_maintains_2018,home).
payment_(alice_maintains_2019).
agent_(alice_maintains_2019,alice).
amount_(alice_maintains_2019,1).
start_(alice_maintains_2019,"2019-01-01").
purpose_(alice_maintains_2019,home).

% Test
:- tax(alice,2017,15037).
:- halt.
