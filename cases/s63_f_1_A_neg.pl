% Text
% In 2017, Alice was paid $33200. Alice and Bob have been married since Feb 3rd, 2017. Alice was born March 2nd, 1950 and Bob was born March 3rd, 1955.

% Question
% Section 63(f)(1)(A) applies to Bob in 2017. Contradiction

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
birth_(alice_is_born).
agent_(alice_is_born,alice).
start_(alice_is_born,"1950-03-02").
end_(alice_is_born,"1950-03-02").
birth_(bob_is_born).
agent_(bob_is_born,bob).
start_(bob_is_born,"1955-03-03").
end_(bob_is_born,"1955-03-03").

% Test
:- \+ s63_f_1_A(bob,2017).
:- halt.
