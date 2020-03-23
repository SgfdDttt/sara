% Text
% In 2017, Alice was paid $33200. Alice and Bob have been married since Feb 3rd, 2017. Bob had no income in 2017. In 2017, Alice and Bob file separately, and Alice takes the standard deduction. Alice and Bob have the same principal place of abode in 2017.

% Question
% How much tax does Alice have to pay in 2017? $4938

% Facts
:- [statutes/prolog/init].
payment_(alice_is_paid).
patient_(alice_is_paid,alice).
start_(alice_is_paid,"2017-12-31").
amount_(alice_is_paid,33200).
marriage_(alice_and_bob).
agent_(alice_and_bob,alice).
agent_(alice_and_bob,bob).
start_(alice_and_bob,"2017-02-03").
marriage_(alice_and_bob).
agent_(alice_and_bob,alice).
agent_(alice_and_bob,bob).
start_(alice_and_bob,"2012-04-05").
residence_(alice_residence).
agent_(alice_residence,alice).
patient_(alice_residence,alice_and_bob_home).
start_(alice_residence,"2017-01-01").
end_(alice_residence,"2017-12-31").
residence_(bob_residence).
agent_(bob_residence,bob).
patient_(bob_residence,alice_and_bob_home).
start_(bob_residence,"2017-01-01").
end_(bob_residence,"2017-12-31").

% Test
:- tax(alice,2017,4938).
:- halt.
