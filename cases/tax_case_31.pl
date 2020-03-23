% Text
% In 2017, Alice was paid $39212, and Bob had no income. Alice and Bob have been married since Feb 3rd, 2017. Alice and Bob file separately in 2017.

% Question
% How much tax does Alice have to pay in 2017? $6621

% Facts
:- [statutes/prolog/init].
payment_(alice_is_paid).
patient_(alice_is_paid,alice).
start_(alice_is_paid,"2017-12-31").
amount_(alice_is_paid,39212).
marriage_(alice_and_bob).
agent_(alice_and_bob,alice).
agent_(alice_and_bob,bob).
start_(alice_and_bob,"2017-02-03").

% Test
:- tax(alice,2017,6621).
:- halt.
