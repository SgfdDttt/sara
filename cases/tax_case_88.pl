% Text
% Alice and Bob got married on Sep 22nd, 2005. Their son Charlie was born Jan 10th, 2002. Bob passed away at the end of 2010. In 2011, Alice paid for her and Charlie's housing, a house that they shared. In 2011, Alice's gross income was $25561 and she took the standard deduction.

% Question
% How much tax does Alice have to pay in 2011? $2334

% Facts
:- [statutes/prolog/init].
marriage_(alice_marriage).
agent_(alice_marriage,alice).
agent_(alice_marriage,bob).
start_(alice_marriage,"2005-09-22").
son_(charlie_is_son).
agent_(charlie_is_son,charlie).
patient_(charlie_is_son,alice).
patient_(charlie_is_son,bob).
start_(charlie_is_son,"2002-01-10").
death_(bob_dies).
agent_(bob_dies,bob).
start_(bob_dies,"2010-12-31").
residence_(alice_residence).
agent_(alice_residence,alice).
patient_(alice_residence,alice_house).
start_(alice_residence,"2011-01-01").
end_(alice_residence,"2011-12-31").
residence_(charlie_residence).
agent_(charlie_residence,charlie).
patient_(charlie_residence,alice_house).
start_(charlie_residence,"2011-01-01").
end_(charlie_residence,"2011-12-31").
payment_(alice_maintains_house).
agent_(alice_maintains_house,alice).
amount_(alice_maintains_house,1).
start_(alice_maintains_house,"2011-01-01").
purpose_(alice_maintains_house,alice_house).
income_(alice_income_2011).
agent_(alice_income_2011,alice).
amount_(alice_income_2011,25561).
start_(alice_income_2011,"2011-12-31").

% Test
:- tax(alice,2011,2334).
:- halt.
