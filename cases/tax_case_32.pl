% Text
% Alice's gross income in 2019 was $5723215. Alice has employed Bob from Jan 2nd, 2011 to Feb 10, 2019. Alice paid Bob $3255 in 2019. On Oct 10, 2019 Bob retired because he reached age 65. Alice paid Bob $12980 as a retirement bonus. In 2019, Alice takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2019? $2242833

% Facts
:- [statutes/prolog/init].
income_(alice_income).
agent_(alice_income,alice).
amount_(alice_income,5723215).
start_(alice_income,"2019-12-31").
service_(alice_employer).
patient_(alice_employer,alice).
agent_(alice_employer,bob).
start_(alice_employer,"2011-01-02").
end_(alice_employer,"2019-10-10").
payment_(alice_pays_bob).
agent_(alice_pays_bob,alice).
patient_(alice_pays_bob,bob).
start_(alice_pays_bob,"2019-12-31").
amount_(alice_pays_bob,3255).
purpose_(alice_pays_bob,alice_employer).
retirement_(bob_retires).
agent_(bob_retires,bob).
start_(bob_retires,"2019-02-10").
reason_(bob_retires,"reached age 65").
payment_(alice_pays_for_bonus).
agent_(alice_pays_for_bonus,alice).
patient_(alice_pays_for_bonus,bob).
start_(alice_pays_for_bonus,"2019-02-10").
amount_(alice_pays_for_bonus,12980).
purpose_(alice_pays_for_bonus,alice_employer).

% Test
:- tax(alice,2019,2242833).
:- halt.
