% Text
% Alice was born January 10th, 1992. Bob was born January 31st, 2014. Alice adopted Bob on March 4th, 2018 and Bob has lived with Alice since, in a house that Alice maintains. Alice's gross income in 2018 was $141177. Alice takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2018? $32045

% Facts
:- [statutes/prolog/init].
:- [statutes/prolog/init].
birth_(alice_is_born).
agent_(alice_is_born,alice).
start_(alice_is_born,"1992-01-10").
end_(alice_is_born,"1992-01-10").
birth_(bob_is_born).
agent_(bob_is_born,bob).
start_(bob_is_born,"2014-01-31").
end_(bob_is_born,"2014-01-31").
son_(alice_and_bob).
agent_(alice_and_bob,bob).
patient_(alice_and_bob,alice).
start_(alice_and_bob,"2018-03-04").
residence_(alice_residence).
agent_(alice_residence,alice).
patient_(alice_residence,alice_home).
start_(alice_residence,"2018-01-01").
residence_(bob_residence).
agent_(bob_residence,bob).
patient_(bob_residence,alice_home).
start_(bob_residence,"2018-01-01").
payment_(alice_maintains_house).
agent_(alice_maintains_house,alice).
amount_(alice_maintains_house,1).
purpose_(alice_maintains_house,alice_home).
start_(alice_maintains_house,"2018-01-01").
end_(alice_maintains_house,"2018-12-31").
income_(alice_income).
agent_(alice_income,alice).
start_(alice_income,"2018-12-31").
amount_(alice_income,141177).

% Test
:- tax(alice,2018,32045).
:- halt.
