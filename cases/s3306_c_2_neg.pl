% Text
% Alice has paid wages of $3200 to Bob for work done from Feb 1st, 2017 to Sep 2nd, 2017, in Baltimore, Maryland, USA for domestic service in her home.

% Question
% Section 3306(c)(2) applies to Alice employing Bob for the year 2017. Contradiction

% Facts
:- discontiguous s3306_b/11.
:- [law/semantics/init].
service_(alice_employer).
patient_(alice_employer,alice).
agent_(alice_employer,bob).
start_(alice_employer,"2017-02-01").
end_(alice_employer,"2017-09-02").
location_(alice_employer,baltimore).
location_(alice_employer,maryland).
location_(alice_employer,usa).
purpose_(alice_employer,"domestic service").
location_(alice_employer,"private home").
payment_(alice_pays).
agent_(alice_pays,alice).
patient_(alice_pays,bob).
start_(alice_pays,"2017-09-02").
purpose_(alice_pays,alice_employer).
amount_(alice_pays,3200).
s3306_b(3200,alice_pays,alice_employer,alice,bob,_,_,_,_,alice,bob)

% Test
:- \+ s3306_c_2(_,alice,2017).
:- halt.
