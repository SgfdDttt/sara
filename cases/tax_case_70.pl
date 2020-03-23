% Text
% Alice has a brother, Bob, who was born January 31st, 2014 and has always lived at his parents' place. In 2016, Alice's gross income was $567192. Alice got married on Jan 12, 2016. Her husband had no income in 2016. Alice does not file a joint return. Alice has itemized deductions of $100206.

% Question
% How much tax does Alice have to pay in 2016? $178147

% Facts
:- [statutes/prolog/init].
brother_(alice_and_bob).
agent_(alice_and_bob,bob).
patient_(alice_and_bob,alice).
start_(alice_and_bob,"2014-01-31").
son_(bob_is_son).
agent_(bob_is_son,bob).
patient_(bob_is_son,bob_parents).
start_(bob_is_son,"2014-01-31").
residence_(bob_parents_residence).
agent_(bob_parents_residence,bob_parents).
patient_(bob_parents_residence,bob_parents_house).
residence_(bob_residence).
agent_(bob_residence,bob).
patient_(bob_residence,bob_parents_house).
start_(bob_residence,"2014-01-31").
income_(alice_income).
agent_(alice_income,alice).
start_(alice_income,"2016-12-31").
amount_(alice_income,567192).
marriage_(alice_marriage).
agent_(alice_marriage,alice).
agent_(alice_marriage,husband).
start_(alice_marriage,"2016-01-12").
deduction_(itemized_deduction).
agent_(itemized_deduction,alice).
amount_(itemized_deduction,100206).
start_(itemized_deduction,"2016-01-01").

% Test
:- tax(alice,2016,178147).
:- halt.
