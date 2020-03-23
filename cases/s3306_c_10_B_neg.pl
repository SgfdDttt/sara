% Text
% Alice was paid $200 in March 2017 for services performed at Johns Hopkins Hospital in March 2017. Alice was a patient at Johns Hopkins Hospital from January 12th, 2017 to February 20th, 2017.

% Question
% Section 3306(c)(10)(B) applies to Alice's employment situation in 2017. Contradiction

% Facts
:- [statutes/prolog/init].
hospital_(hopkins_is_a_hospital).
agent_(hopkins_is_a_hospital,"johns hopkins hospital").
service_(alice_employed).
patient_(alice_employed,"johns hopkins hospital").
agent_(alice_employed,alice).
start_(alice_employed,"2017-03-01").
end_(alice_employed,"2017-03-31").
location_(alice_employed,baltimore).
location_(alice_employed,maryland).
location_(alice_employed,usa).
payment_(alice_is_paid).
agent_(alice_is_paid,"johns hopkins hospital").
patient_(alice_is_paid,alice).
start_(alice_is_paid,"2017-03-31").
purpose_(alice_is_paid,alice_employed).
amount_(alice_is_paid,200).
medical_patient_(alice_goes_to_hopkins).
agent_(alice_goes_to_hopkins,alice).
patient_(alice_goes_to_hopkins,"johns hopkins hospital").
start_(alice_goes_to_hopkins,"2017-01-12").
end_(alice_goes_to_hopkins,"2017-02-20").

% Test
:- \+ s3306_c_10_B(alice_employed,_,alice,"2017-03-01").
:- halt.
