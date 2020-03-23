% Text
% In 2017, Alice was paid $36266. Alice and Bob have been married since Feb 3rd, 2017. Alice was born March 2nd, 1950 and Bob was born March 3rd, 1951. Bob had no income in 2017. Alice and Bob file separately in 2017. Alice takes the standard deduction. Alice and Bob have the same principal place of abode in 2017.

% Question
% How much tax does Alice have to pay in 2017? $5460

% Facts
:- [statutes/prolog/init].
payment_(alice_is_paid).
patient_(alice_is_paid,alice).
start_(alice_is_paid,"2017-12-31").
amount_(alice_is_paid,36266).
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
start_(bob_is_born,"1951-03-03").
end_(bob_is_born,"1951-03-03").
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
:- tax(alice,2017,5460).
:- halt.
