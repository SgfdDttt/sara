% Text
% Alice has paid wages of $3200 to Bob for work done from Feb 1st, 2017 to Sep 2nd, 2017. Bob has paid wages of $4500 to Alice for work done from Apr 1st, 2017 to Sep 2nd, 2018.

% Question
% Section 3306(a)(1)(A) make Alice an employer for the year 2017. Entailment

% Facts
:- discontiguous s3306_b/11.
:- [statutes/prolog/init].
s3306_b(3200,_,bob_works,alice,bob,_,_,_,_,alice,bob).
start_(bob_works,"2017-02-01").
end_(bob_works,"2017-09-02").
s3306_b(4500,_,alice_works,bob,alice,_,_,_,_,bob,alice).
start_(alice_works,"2017-04-01").
end_(alice_works,"2018-09-02").

% Test
:- s3306_a_1_A(alice,2017,_).
:- halt.
