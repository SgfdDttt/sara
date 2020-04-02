% Text
% Alice has a son, Bob. From September 1st, 2015 to November 3rd, 2019, Alice and Bob lived in the same home. Bob married Charlie on October 23rd, 2018. Bob satisfied section 152(c)(2) and 152(c)(3) with Alice as the taxpayer for the years 2015 to 2020.

% Question
% Under section 152(c)(1), Bob is a qualifying child of Alice for the year 2019. Entailment

% Facts
:- discontiguous s152_c_2/4.
:- discontiguous s152_c_3/3.
:- [statutes/prolog/init].
son_(bob_is_son).
agent_(bob_is_son,bob).
patient_(bob_is_son,alice).
residence_(alice_and_bob).
agent_(alice_and_bob,alice).
agent_(alice_and_bob,bob).
patient_(alice_and_bob,home).
start_(alice_and_bob,"2015-09-01").
end_(alice_and_bob,"2019-11-03").
marriage_(bob_and_charlie).
agent_(bob_and_charlie,bob).
agent_(bob_and_charlie,charlie).
start_(bob_and_charlie,"2018-10-23").
s152_c_2(bob,alice,"2015-01-01","2020-12-31").
s152_c_3(bob,alice,Year) :- between(2015,2020,Year).

% Test
:- s152_c_1(bob,alice,2019).
:- halt.
