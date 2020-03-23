% Text
% Alice and Bob got married on Sep 12nd, 1998. Their son Charlie was born October 1st, 2013. Bob passed away March 2nd, 2015. In 2017, Alice and Charlie live at a house maintained by Alice. Alice's gross income for the year 2017 was $70117. Alice takes the standard deduction in 2017.

% Question
% How much tax does Alice have to pay in 2017? $12036

% Facts
:- [statutes/prolog/init].
marriage_(alice_marriage).
agent_(alice_marriage,alice).
agent_(alice_marriage,bob).
start_(alice_marriage,"1998-09-12").
son_(charlie_is_son).
agent_(charlie_is_son,charlie).
patient_(charlie_is_son,alice).
patient_(charlie_is_son,bob).
start_(charlie_is_son,"2013-10-01").
death_(bob_dies).
agent_(bob_dies,bob).
start_(bob_dies,"2015-03-02").
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
amount_(alice_income_2017,70117).
start_(alice_income_2017,"2017-12-31").

% Test
:- tax(alice,2017,12036).
:- halt.
