% Text
% Alice was paid $73200 in 2017 as an employee of Nando's Chicken in Arlington, Virginia, USA.

% Question
% Section 3306(c)(6) applies to Alice's employment situation in 2017. Contradiction

% Facts
:- [statutes/prolog/init].
service_(alice_employed).
patient_(alice_employed,"nando's chicken").
agent_(alice_employed,alice).
start_(alice_employed,"2017-01-01").
end_(alice_employed,"2017-12-31").
location_(alice_employed,"arlington").
location_(alice_employed,"virginia").
location_(alice_employed,"usa").
payment_(alice_is_paid).
agent_(alice_is_paid,"nando's chicken").
patient_(alice_is_paid,alice).
start_(alice_is_paid,"2017-12-31").
purpose_(alice_is_paid,alice_employed).
amount_(alice_is_paid,73200).

% Test
:- \+ s3306_c_6(alice_employed).
:- halt.
