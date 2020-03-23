% Text
% In 2017, Alice was paid $33200. Alice and Bob have been married since Feb 3rd, 2017, and they file a joint return for 2017. 

% Question
% Under section 63(c)(2)(B), Alice's basic standard deduction in 2017 is equal to $4400. Contradiction

% Facts
:- [law/semantics/init].
payment_(alice_is_paid).
patient_(alice_is_paid,alice).
start_(alice_is_paid,"2017-12-31").
amount_(alice_is_paid,33200).
marriage_(alice_and_bob).
agent_(alice_and_bob,alice).
agent_(alice_and_bob,bob).
start_(alice_and_bob,"2017-02-03").
joint_return_(alice_and_bob_file_a_joint_return).
agent_(alice_and_bob_file_a_joint_return,alice).
agent_(alice_and_bob_file_a_joint_return,bob).
start_(alice_and_bob_file_a_joint_return,"2017-01-01").
end_(alice_and_bob_file_a_joint_return,"2017-12-31").

% Test
:- \+ s63_c_2_B(alice,2017,4400).
:- halt.
