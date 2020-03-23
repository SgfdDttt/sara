% Text
% In 2017, Alice's gross income was $33200. Alice and Bob have been married since Feb 3rd, 2017. Alice has been blind since October 4, 2013. Alice and Bob file jointly in 2017. Bob has no gross income in 2017. Alice and Bob take the standard deduction. Alice and Bob has the same principal place of abode from 2017 to 2020.

% Question
% How much tax does Alice have to pay in 2017? $3390

% Facts
:- [statutes/prolog/init].
income_(alice_is_paid).
agent_(alice_is_paid,alice).
start_(alice_is_paid,"2017-12-31").
amount_(alice_is_paid,33200).
marriage_(alice_and_bob).
agent_(alice_and_bob,alice).
agent_(alice_and_bob,bob).
start_(alice_and_bob,"2017-02-03").
blindness_(alice_is_blind).
agent_(alice_is_blind,alice).
start_(alice_is_blind,"2013-10-04").
joint_return_(alice_and_bob_joint_return).
agent_(alice_and_bob_joint_return,alice).
agent_(alice_and_bob_joint_return,bob).
start_(alice_and_bob_joint_return,"2017-01-01").
end_(alice_and_bob_joint_return,"2017-12-31").
residence_(alice_residence).
agent_(alice_residence,alice).
patient_(alice_residence,home).
start_(alice_residence,"2017-01-01").
end_(alice_residence,"2020-12-31").
residence_(bob_residence).
agent_(bob_residence,bob).
patient_(bob_residence,home).
start_(bob_residence,"2017-01-01").
end_(bob_residence,"2020-12-31").

% Test
:- tax(alice,2017,3390).
:- halt.
