% Text
% In 2019, Alice was paid $33200. Alice and Bob have been married since Feb 3rd, 2019. Alice and Bob file separate returns in 2019.

% Question
% Under section 63(c)(7)(ii), Alice's basic standard deduction in 2019 is equal to $12000. Entailment

% Facts
:- [statutes/prolog/init].
payment_(alice_is_paid).
patient_(alice_is_paid,alice).
start_(alice_is_paid,"2019-12-31").
amount_(alice_is_paid,33200).
marriage_(alice_and_bob).
agent_(alice_and_bob,alice).
agent_(alice_and_bob,bob).
start_(alice_and_bob,"2019-02-03").

% Test
:- s63_c_7_ii(2019,12000).
:- halt.
