% Text
% Alice was paid $200 in March 2017 for services performed at Johns Hopkins Hospital. Alice was a patient at Johns Hopkins Hospital from March 15th, 2017 to April 2nd, 2017. In 2017, Alice was also paid $31220 in remuneration. Alice takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2017? $4525

% Facts
:- [statutes/prolog/init].
hospital_(hopkins_is_a_hospital).
agent_(hopkins_is_a_hospital,"johns hopkins hospital").
service_(alice_employed).
patient_(alice_employed,"johns hopkins hospital").
agent_(alice_employed,alice).
start_(alice_employed,"2017-03-15").
end_(alice_employed,"2017-03-31").
location_(alice_employed,"baltimore").
location_(alice_employed,"maryland").
location_(alice_employed,"usa").
payment_(alice_is_paid).
agent_(alice_is_paid,"johns hopkins hospital").
patient_(alice_is_paid,alice).
start_(alice_is_paid,"2017-03-31").
purpose_(alice_is_paid,alice_employed).
amount_(alice_is_paid,200).
medical_patient_(alice_goes_to_hopkins).
agent_(alice_goes_to_hopkins,alice).
patient_(alice_goes_to_hopkins,"johns hopkins hospital").
start_(alice_goes_to_hopkins,"2017-03-15").
end_(alice_goes_to_hopkins,"2017-04-02").
income_(alice_income_2017).
agent_(alice_income_2017,alice).
start_(alice_income_2017,"2017-12-31").
amount_(alice_income_2017,31220).

% Test
:- tax(alice,2017,4525).
:- halt.
