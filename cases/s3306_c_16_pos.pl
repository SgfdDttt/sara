% Text
% Alice was paid $73200 in 2017 as an employee of the International Monetary Fund in Washington, D.C., USA.

% Question
% Section 3306(c)(16) applies to Alice's employment situation in 2017. Entailment

% Facts
:- [statutes/prolog/init].
international_organization_(imf_is_an_international_organization).
agent_(imf_is_an_international_organization,"international monetary fund").
service_(alice_employed).
patient_(alice_employed,"international monetary fund").
agent_(alice_employed,alice).
start_(alice_employed,"2017-01-01").
end_(alice_employed,"2017-12-31").
location_(alice_employed,"washington dc").
location_(alice_employed,usa).
payment_(alice_is_paid).
agent_(alice_is_paid,"international monetary fund").
patient_(alice_is_paid,alice).
start_(alice_is_paid,"2017-12-31").
purpose_(alice_is_paid,alice_employed).
amount_(alice_is_paid,73200).

% Test
:- s3306_c_16(alice_employed,_,_).
:- halt.
