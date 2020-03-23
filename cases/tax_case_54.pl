% Text
% Alice and Bob got married on Feb 3rd, 1998, and have a son Charlie, born April 1st, 1999. Bob died on Jan 1st, 2017. In 2019, Charlie lives at the house that Alice maintains as her principal place of abode. Alice's gross income for the year 2019 is $236422. Alice takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2019? $62000

% Facts
:- [statutes/prolog/init].
marriage_(alice_marriage).
agent_(alice_marriage,alice).
agent_(alice_marriage,bob).
start_(alice_marriage,"1998-02-03").
son_(charlie_is_son).
agent_(charlie_is_son,charlie).
patient_(charlie_is_son,alice).
patient_(charlie_is_son,bob).
start_(charlie_is_son,"1999-04-01").
death_(bob_dies).
agent_(bob_dies,bob).
start_(bob_dies,"2017-01-01").
residence_(charlie_residence).
agent_(charlie_residence,charlie).
patient_(charlie_residence,alice_house).
start_(charlie_residence,"2019-01-01").
end_(charlie_residence,"2019-12-31").
payment_(alice_maintains_house).
agent_(alice_maintains_house,alice).
amount_(alice_maintains_house,1).
start_(alice_maintains_house,"2019-01-01").
purpose_(alice_maintains_house,alice_house).
residence_(alice_residence).
agent_(alice_residence,alice).
patient_(alice_residence,alice_house).
start_(alice_residence,"2019-01-01").
end_(alice_residence,"2019-12-31").
income_(alice_income_2019).
agent_(alice_income_2019,alice).
amount_(alice_income_2019,236422).
start_(alice_income_2019,"2019-12-31").

% Test
:- tax(alice,2019,62000).
:- halt.
