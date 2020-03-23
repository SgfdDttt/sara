% Text
% Alice was paid $3200 in 2017 for services performed for Johns Hopkins School of Nursing. Alice was enrolled at Johns Hopkins School of Nursing and attending classes from August 29, 2015 to May 30th, 2019.

% Question
% Section 3306(c)(13) applies to Alice's employment situation in 2017. Entailment

% Facts
:- [statutes/prolog/init].
service_(alice_employed).
patient_(alice_employed,"johns hopkins school of nursing").
agent_(alice_employed,alice).
start_(alice_employed,"2017-01-01").
end_(alice_employed,"2017-12-31").
location_(alice_employed,baltimore).
location_(alice_employed,maryland).
location_(alice_employed,usa).
payment_(alice_is_paid).
agent_(alice_is_paid,"johns hopkins school of nursing").
patient_(alice_is_paid,alice).
start_(alice_is_paid,"2017-12-31").
purpose_(alice_is_paid,alice_employed).
amount_(alice_is_paid,3200).
nurses_training_school_(hopkins_is_a_nursing_school).
agent_(hopkins_is_a_nursing_school,"johns hopkins school of nursing").
enrollment_(alice_goes_to_hopkins).
agent_(alice_goes_to_hopkins,alice).
patient_(alice_goes_to_hopkins,"johns hopkins school of nursing").
start_(alice_goes_to_hopkins,"2015-08-29").
end_(alice_goes_to_hopkins,"2019-05-30").
attending_classes_(alice_goes_to_class).
agent_(alice_goes_to_class,alice).
location_(alice_goes_to_class,"johns hopkins school of nursing").
start_(alice_goes_to_class,"2015-08-29").
end_(alice_goes_to_class,"2019-05-30").

% Test
:- s3306_c_13(alice_employed,_,_,"2017-01-01").
:- halt.
