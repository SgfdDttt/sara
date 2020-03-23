% Text
% In 2017, Alice's gross income was $44215. Alice and Bob have been married since Oct 10th, 2017. Alice and Bob file separately. Alice has paid $3200 in cash to Bob for work done from Feb 1st, 2017 to Sep 2nd, 2017 for agricultural labor. Alice takes the standard deduction. Alice and Bob live separately in 2017.

% Question
% How much tax does Alice have to pay in 2017? $8582

% Facts
:- [statutes/prolog/init].
income_(alice_is_paid).
agent_(alice_is_paid,alice).
start_(alice_is_paid,"2017-12-31").
amount_(alice_is_paid,44215).
marriage_(alice_and_bob).
agent_(alice_and_bob,alice).
agent_(alice_and_bob,bob).
start_(alice_and_bob,"2017-10-10").
service_(alice_employer).
patient_(alice_employer,alice).
agent_(alice_employer,bob).
start_(alice_employer,"2017-02-01").
end_(alice_employer,"2017-09-02").
purpose_(alice_employer,"agricultural labor").
payment_(alice_pays).
agent_(alice_pays,alice).
patient_(alice_pays,bob).
start_(alice_pays,"2017-09-02").
purpose_(alice_pays,alice_employer).
amount_(alice_pays,3200).
means_(alice_pays,"cash").
residence_(alice_residence).
agent_(alice_residence,alice).
patient_(alice_residence,alice_home).
start_(alice_residence,"2017-01-01").
end_(alice_residence,"2017-12-31").
residence_(bob_residence).
agent_(bob_residence,bob).
patient_(bob_residence,bob_home).
start_(bob_residence,"2017-01-01").
end_(bob_residence,"2017-12-31").

% Test
:- tax(alice,2017,8582).
:- halt.
