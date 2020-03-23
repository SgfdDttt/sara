% Text
% Alice has paid wages of $3200 to Bob for work done from Feb 1st, 2017 to Sep 2nd, 2017 for domestic service. In 2018, Bob has paid wages of $4500 to Alice for work done from Apr 1st, 2017 to Sep 2nd, 2018.

% Question
% Bob is an employer under section 3306(a)(1) for the year 2018. Entailment

% Facts
:- discontiguous s3306_b/11.
:- [statutes/prolog/init].
service_(alice_employer).
patient_(alice_employer,alice).
agent_(alice_employer,bob).
start_(alice_employer,"2017-02-01").
end_(alice_employer,"2017-09-02").
purpose_(alice_employer,"domestic service").
payment_(alice_pays).
agent_(alice_pays,alice).
patient_(alice_pays,bob).
start_(alice_pays,"2019-09-02").
purpose_(alice_pays,alice_employer).
amount_(alice_pays,3200).
s3306_b(3200,alice_pays,alice_employer,alice,bob,_,_,_,_,alice,bob).
service_(bob_employer).
patient_(bob_employer,bob).
agent_(bob_employer,alice).
start_(bob_employer,"2017-02-01").
end_(bob_employer,"2017-09-02").
payment_(bob_pays).
agent_(bob_pays,bob).
patient_(bob_pays,alice).
start_(bob_pays,"2018-09-02").
end_(bob_pays,"2018-09-02").
purpose_(bob_pays,bob_employer).
amount_(bob_pays,4500).
s3306_b(4500,bob_pays,bob_employer,bob,alice,_,_,_,_,bob,alice).

% Test
:- s3306_a_1(bob,2018,_).
:- halt.
