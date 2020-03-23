% Text
% Alice was paid $200 in March 2017 for services performed at Johns Hopkins Hospital. Alice was a patient at Johns Hopkins Hospital from March 15th, 2017 to April 2nd, 2017. Bob is Alice's son since April 15th, 2014. Bob and Alice have the same principal place of abode, a house maintained by Alice. Alice takes the standard deduction in 2017.

% Question
% How much tax does Alice have to pay in 2017? $0

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
son_(alice_and_bob).
agent_(alice_and_bob,bob).
patient_(alice_and_bob,alice).
start_(alice_and_bob,"2014-04-15").
residence_(alice_residence).
agent_(alice_residence,alice).
patient_(alice_residence,alice_house).
start_(alice_residence,"2017-01-01").
end_(alice_residence,"2017-12-31").
residence_(bob_residence).
agent_(bob_residence,bob).
patient_(bob_residence,alice_house).
start_(bob_residence,"2017-01-01").
end_(bob_residence,"2017-12-31").
payment_(alice_maintains_house).
agent_(alice_maintains_house,alice).
purpose_(alice_maintains_house,alice_house).
start_(alice_maintains_house,"2017-12-31").
amount_(alice_maintains_house,1).

% Test
:- tax(alice,2017,0).
:- halt.
