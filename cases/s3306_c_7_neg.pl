% Text
% Alice was paid $73200 in 2017 as an employee of Bertha's Mussels in Baltimore, Maryland, USA.

% Question
% Section 3306(c)(7) applies to Alice's employment situation in 2017. Contradiction

% Facts
:- [law/semantics/init].
service_(alice_employed).
patient_(alice_employed,"bertha's mussels").
agent_(alice_employed,alice).
start_(alice_employed,"2017-01-01").
end_(alice_employed,"2017-12-31").
location_(alice_employed,baltimore).
location_(alice_employed,maryland).
location_(alice_employed,usa).
payment_(alice_is_paid).
agent_(alice_is_paid,"bertha's mussels").
patient_(alice_is_paid,alice).
start_(alice_is_paid,"2017-12-31").
purpose_(alice_is_paid,alice_employed).
amount_(alice_is_paid,73200).

% Test
:- \+ s3306_c_7(alice_employed).
:- halt.
