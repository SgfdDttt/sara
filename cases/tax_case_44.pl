% Text
% In 2017, Alice was paid $117192. Alice and Bob got married on Feb 3rd, 2017. Alice was a nonresident alien from August 23rd, 2016 to September 15th, 2018. Bob earned $37820 in 2017. Alice takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2017? $34233

% Facts
:- [statutes/prolog/init].
payment_(alice_is_paid).
patient_(alice_is_paid,alice).
start_(alice_is_paid,"2017-12-31").
amount_(alice_is_paid,117192).
marriage_(alice_and_bob).
agent_(alice_and_bob,alice).
agent_(alice_and_bob,bob).
start_(alice_and_bob,"2017-02-03").
nonresident_alien_(alice_is_a_nra).
agent_(alice_is_a_nra,alice).
start_(alice_is_a_nra,"2016-08-23").
end_(alice_is_a_nra,"2018-08-15").
income_(bob_income).
agent_(bob_income,bob).
start_(bob_income,"2017-12-31").
amount_(bob_income,37820).

% Test
:- tax(alice,2017,34233).
:- halt.
