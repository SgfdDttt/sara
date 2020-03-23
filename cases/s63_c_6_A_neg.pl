% Text
% In 2017, Alice was paid $33200. Alice and Bob have been married since Feb 3rd, 2017. Bob and Alice file a joint return for 2017.

% Question
% Section 63(c)(6)(A) applies to Alice for 2017. Contradiction

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
joint_return_(bob_and_alice_joint_return).
agent_(bob_and_alice_joint_return,bob).
agent_(bob_and_alice_joint_return,alice).
start_(bob_and_alice_joint_return,"2017-01-01").
end_(bob_and_alice_joint_return,"2017-12-31").

% Test
:- \+ s63_c_6_A(alice,_,_,2017).
:- halt.
