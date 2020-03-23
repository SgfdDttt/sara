% Text
% Alice has paid $3200 to Bob for work done from Feb 1st, 2017 to Sep 2nd, 2017 for agricultural labor. Alice paid Bob with eggs, grapes and hay.

% Question
% Section 3306(b)(11) applies to the payment that Alice made to Bob for the year 2017. Entailment

% Facts
:- [statutes/prolog/init].
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
means_(alice_pays,"kind").

% Test
:- s3306_b_11(alice_pays,alice_employer).
:- halt.
