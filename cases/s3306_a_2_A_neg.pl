% Text
% Alice has paid wages of $3200 to Bob for work done from Feb 1st, 2017 to Sep 2nd, 2017 for agricultural labor. Bob has paid wages of $4520 to Alice for work done from Apr 1st, 2017 to Sep 2nd, 2018.

% Question
% Section 3306(a)(2)(A) make Alice an employer for the year 2017. Contradiction

% Facts
:- discontiguous s3306_b/11.
:- [law/semantics/init].
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
s3306_b(3200,alice_pays,alice_employer,alice,bob,_,_,_,_,alice,bob).
service_(bob_employer).
patient_(bob_employer,bob).
agent_(bob_employer,alice).
start_(bob_employer,"2017-04-01").
end_(bob_employer,"2018-09-02").
payment_(bob_pays).
agent_(bob_pays,bob).
patient_(bob_pays,alice).
start_(bob_pays,"2018-09-02").
purpose_(bob_pays,bob_employer).
amount_(bob_pays,4520).
s3306_b(4520,bob_pays,bob_employer,bob,alice,_,_,_,_,bob,alice).

% Test
:- \+ s3306_a_2_A(alice,2017,_).
:- halt.
