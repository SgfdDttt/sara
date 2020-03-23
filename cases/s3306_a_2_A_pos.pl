% Text
% Alice has paid wages of $6771, $6954, $6872 to Bob, Charlie and Dan respectively for work done from Feb 1st, 2017 to Sep 2nd, 2017 for agricultural labor. Bob has paid wages of $4520 to Alice for work done from Apr 1st, 2017 to Sep 2nd, 2018.

% Question
% Section 3306(a)(2)(A) make Alice an employer for the year 2017. Entailment

% Facts
:- discontiguous s3306_b/11.
:- [law/semantics/init].
service_(alice_employer_bob).
patient_(alice_employer_bob,alice).
agent_(alice_employer_bob,bob).
start_(alice_employer_bob,"2017-02-01").
end_(alice_employer_bob,"2017-09-02").
purpose_(alice_employer_bob,"agricultural labor").
payment_(alice_pays_bob).
agent_(alice_pays_bob,alice).
patient_(alice_pays_bob,bob).
start_(alice_pays_bob,"2017-09-02").
purpose_(alice_pays_bob,alice_employer_bob).
amount_(alice_pays_bob,6771).
s3306_b(6771,alice_pays_bob,alice_employer_bob,alice,bob,_,_,_,_,alice,bob).
service_(alice_employer_charlie).
patient_(alice_employer_charlie,alice).
agent_(alice_employer_charlie,charlie).
start_(alice_employer_charlie,"2017-02-01").
end_(alice_employer_charlie,"2017-09-02").
purpose_(alice_employer_charlie,"agricultural labor").
payment_(alice_pays_charlie).
agent_(alice_pays_charlie,alice).
patient_(alice_pays_charlie,charlie).
start_(alice_pays_charlie,"2017-09-02").
purpose_(alice_pays_charlie,alice_employer_charlie).
amount_(alice_pays_charlie,6954).
s3306_b(6954,alice_pays_charlie,alice_employer_charlie,alice,charlie,_,_,_,_,alice,charlie).
service_(alice_employer_dan).
patient_(alice_employer_dan,alice).
agent_(alice_employer_dan,dan).
start_(alice_employer_dan,"2017-02-01").
end_(alice_employer_dan,"2017-09-02").
purpose_(alice_employer_dan,"agricultural labor").
payment_(alice_pays_dan).
agent_(alice_pays_dan,alice).
patient_(alice_pays_dan,dan).
start_(alice_pays_dan,"2017-09-02").
purpose_(alice_pays_dan,alice_employer_dan).
amount_(alice_pays_dan,6872).
s3306_b(6872,alice_pays_dan,alice_employer_dan,alice,dan,_,_,_,_,alice,dan).
service_(bob_employer).
patient_(bob_employer,bob).
agent_(bob_employer,alice).
start_(bob_employer,"2017-04-01").
end_(bob_employer,"2018-09-02").
payment_(bob_pays).
agent_(bob_pays,bob).
patient_(bob_pays,alice).
start_(bob_pays,"2018-09-02").
end_(bob_pays,"2018-09-02").
purpose_(bob_pays,bob_employer).
amount_(bob_pays,4520).
s3306_b(4520,bob_pays,bob_employer,bob,alice,_,_,_,_,bob,alice).

% Test
:- s3306_a_2_A(alice,2017,_).
:- halt.
