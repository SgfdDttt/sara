% Text
% Alice and Bob have been married since 2 Feb 2015. Bob has no income for 2015. Alice and Bob file their taxes jointly for 2015.

% Question
% Alice can receive an exemption for Bob under section 151(b) for the year 2015. Contradiction

% Facts
:- [statutes/prolog/init].
marriage_(alice_and_bob).
agent_(alice_and_bob,alice).
agent_(alice_and_bob,bob).
start_(alice_and_bob,"2015-02-02").
joint_return_(alice_and_bob_joint_return).
agent_(alice_and_bob_joint_return,alice).
agent_(alice_and_bob_joint_return,bob).
start_(alice_and_bob_joint_return,"2015-01-01").
end_(alice_and_bob_joint_return,"2015-12-31").

% Test
:- \+ s151_b(alice,bob,2015).
:- halt.
