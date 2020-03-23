% Text
% Alice and Bob got married on Aug 6th, 2010. Their son Charlie was born February 2nd, 2012. Alice and Bob were legally separated under a decree of divorce on March 2nd, 2015. In 2017, Alice and Charlie live at a house maintained by Alice. Alice's gross income for the year 2017 is $9560. Alice takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2017? $174

% Facts
:- [statutes/prolog/init].
marriage_(alice_marriage).
agent_(alice_marriage,alice).
agent_(alice_marriage,bob).
start_(alice_marriage,"2010-08-06").
son_(charlie_is_son).
agent_(charlie_is_son,charlie).
patient_(charlie_is_son,alice).
patient_(charlie_is_son,bob).
start_(charlie_is_son,"2012-02-02").
legal_separation_(alice_and_bob_divorce).
patient_(alice_and_bob_divorce,alice_marriage).
agent_(alice_and_bob_divorce,"decree of divorce").
start_(alice_and_bob_divorce,"2015-03-02").
residence_(alice_residence).
agent_(alice_residence,alice).
patient_(alice_residence,alice_house).
start_(alice_residence,"2017-01-01").
end_(alice_residence,"2017-12-31").
residence_(charlie_residence).
agent_(charlie_residence,charlie).
patient_(charlie_residence,alice_house).
start_(charlie_residence,"2017-01-01").
end_(charlie_residence,"2017-12-31").
payment_(alice_maintains_house).
agent_(alice_maintains_house,alice).
amount_(alice_maintains_house,1).
start_(alice_maintains_house,"2017-01-01").
purpose_(alice_maintains_house,alice_house).
income_(alice_income_2017).
agent_(alice_income_2017,alice).
start_(alice_income_2017,"2017-12-31").
amount_(alice_income_2017,9560).

% Test
:- tax(alice,2017,174).
:- halt.
